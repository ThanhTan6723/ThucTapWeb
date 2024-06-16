package controller.client.cart;

import dao.client.ProductDAO;
import model.Discount;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@WebServlet("/CheckDiscountServlet")
public class CheckDiscountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String couponCode = request.getParameter("couponCode");
        String quantityStr = request.getParameter("quantity");
        String totalAmountStr = request.getParameter("totalAmount");
        String modifiedString = totalAmountStr.substring(0, totalAmountStr.length() - 1);
        double totalAmount = Double.parseDouble(modifiedString);
        int quantity = Integer.parseInt(quantityStr);

        JSONObject jsonResponse = new JSONObject();

        try {
            jsonResponse = checkCouponCodeValidity(couponCode, quantity, totalAmount);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }

    private JSONObject checkCouponCodeValidity(String couponCode, int quantity, double totalAmount) throws SQLException {
        JSONObject jsonResponse = new JSONObject();
        Discount discount = ProductDAO.getDiscountByCode(couponCode);

        if (discount != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = discount.getStartDate();
            Date endDate = discount.getEndDate();
            Date currentDate = new Date();

            try {
                startDate = dateFormat.parse(dateFormat.format(startDate));
                endDate = dateFormat.parse(dateFormat.format(endDate));
            } catch (ParseException e) {
                e.printStackTrace();
            }

            LocalDate localStartDate = convertToLocalDate(startDate);
            LocalDate localEndDate = convertToLocalDate(endDate);
            LocalDate localCurrentDate = LocalDate.now();

            if (localCurrentDate.isBefore(localStartDate) || localCurrentDate.isAfter(localEndDate)) {
                jsonResponse.put("valid", false);
                jsonResponse.put("error", "Mã giảm giá không còn hiệu lực");
                return jsonResponse;
            }

            if (discount.getDiscountType().equals("all")) {
                double discountedPrice = totalAmount * (1 - discount.getDiscountValue());
                jsonResponse.put("valid", true);
                jsonResponse.put("discountedPrice", discountedPrice);
                jsonResponse.put("discountValue", discount.getDiscountValue());
                return jsonResponse;
            }
        }
        jsonResponse.put("valid", false);
        jsonResponse.put("error", "Mã giảm giá không tồn tại");
        return jsonResponse;
    }
    private LocalDate convertToLocalDate(Date dateToConvert) {
        return new java.sql.Date(dateToConvert.getTime()).toLocalDate();
    }
}
