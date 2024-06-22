package controller.client.voucher;

import dao.client.VoucherDAO;
import model.Voucher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.io.PrintWriter;

@WebServlet(name = "ApplyVoucherControll", value = "/ApplyVoucherControll")
public class ApplyVoucherControll extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String voucherIdStr = request.getParameter("voucherId");

        if (voucherIdStr != null && !voucherIdStr.isEmpty()) {
            int voucherId = Integer.parseInt(voucherIdStr);
            // Lấy thông tin voucher từ cơ sở dữ liệu
            Voucher voucher = VoucherDAO.getVoucherById(voucherId);
            System.out.println(voucherId);
            System.out.println(voucher);
            if (voucher != null) {
                String discountType = voucher.getDiscountType().getType();

                if ("All".equalsIgnoreCase(discountType)) {
                    // Tính toán và áp dụng giảm giá cho loại voucher "All"
                    BigDecimal totalAmount = getTotalAmountFromRequest(request); // Thay bằng phương thức lấy tổng tiền từ request của bạn
                    BigDecimal discountPercentage = voucher.getDiscountPercentage();
                    BigDecimal discountedAmount = calculateDiscountedAmount(totalAmount, discountPercentage);

                    // Cập nhật các giá trị trả về cho client
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print("{\"discountedAmount\": \"" + discountedAmount.toString() + "\"}");
                    out.flush();
                } else {
                    // Xử lý các loại giảm giá khác nếu cần
                    response.setStatus(HttpServletResponse.SC_NOT_IMPLEMENTED);
                }
            } else {
                // Xử lý khi không tìm thấy voucher
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } else {
            // Xử lý khi thiếu thông tin voucherId
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    private BigDecimal getTotalAmountFromRequest(HttpServletRequest request) {
        // Thực hiện lấy tổng tiền từ request, ví dụ:
        String totalAmountStr = request.getParameter("totalAmount");
        if (totalAmountStr != null && !totalAmountStr.isEmpty()) {
            return new BigDecimal(totalAmountStr);
        }
        return BigDecimal.ZERO;
    }

    private BigDecimal calculateDiscountedAmount(BigDecimal totalAmount, BigDecimal discountPercentage) {
        // Thực hiện tính toán giảm giá dựa vào tổng tiền và phần trăm giảm giá
        return totalAmount.multiply(discountPercentage).divide(new BigDecimal(100));
    }
}
