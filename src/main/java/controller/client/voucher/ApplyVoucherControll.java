package controller.client.voucher;

import dao.client.VoucherDAO;
import model.OrderDetail;
import model.Voucher;
import model.Product;
import model.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

@WebServlet(name = "ApplyVoucherControll", urlPatterns = {"/ApplyVoucherControll"})
public class ApplyVoucherControll extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int voucherId = Integer.parseInt(request.getParameter("voucherId"));
        BigDecimal totalAmount = new BigDecimal(request.getParameter("totalAmount"));

        Voucher voucher = VoucherDAO.getVoucherById(voucherId);
        BigDecimal discountValue = BigDecimal.ZERO;

        System.out.println(voucher);

        if (voucher != null) {
            HttpSession session = request.getSession();
            Object obj = session.getAttribute("cart");
            Map<Integer, OrderDetail> cart = (Map<Integer, OrderDetail>) obj;
            System.out.println(cart);

            switch (voucher.getDiscountType().getType()) {
                case "Product":
                    // Lấy % giảm giá
                    BigDecimal productDiscountPercentage = voucher.getDiscountPercentage().divide(new BigDecimal(100));

                    // Duyệt qua các sản phẩm trong giỏ hàng và tính giảm giá cho sản phẩm có product id tương ứng
                    for (OrderDetail orderDetail : cart.values()) {
                        if (orderDetail.getProduct().getId() == voucher.getProduct().getId()) {
                            BigDecimal totalProductPrice = new BigDecimal(orderDetail.getPrice()).multiply(new BigDecimal(orderDetail.getQuantity()));
                            BigDecimal productDiscount = totalProductPrice.multiply(productDiscountPercentage);
                            discountValue = discountValue.add(productDiscount);
                        }
                    }
                    break;
                case "Category":
                    // Lấy % giảm giá
                    BigDecimal categoryDiscountPercentage = voucher.getDiscountPercentage().divide(new BigDecimal(100));

                    // Duyệt qua danh sách đơn hàng và tính giảm giá cho tất cả sản phẩm thuộc category tương ứng
                    for (OrderDetail orderDetail : cart.values()) {
                        if (orderDetail.getProduct().getCategory().getId() == voucher.getCategory().getId()) {
                            BigDecimal totalCategoryPrice = new BigDecimal(orderDetail.getPrice()).multiply(new BigDecimal(orderDetail.getQuantity()));
                            discountValue = discountValue.add(totalCategoryPrice);
                        }
                    }
                    discountValue = discountValue.multiply(categoryDiscountPercentage);
                    break;
                case "All":
                    // Lấy % giảm giá
                    BigDecimal allDiscountPercentage = voucher.getDiscountPercentage().divide(new BigDecimal(100));

                    // Áp dụng giảm giá cho tổng hóa đơn
                    discountValue = totalAmount.multiply(allDiscountPercentage);
                    break;
            }
        }

        BigDecimal finalAmount = totalAmount.subtract(discountValue);

        response.setContentType("application/json");
        response.getWriter().write("{\"discountValue\": \"" + discountValue.toPlainString() + "\", \"finalAmount\": \"" + finalAmount.toPlainString() + "\"}");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
