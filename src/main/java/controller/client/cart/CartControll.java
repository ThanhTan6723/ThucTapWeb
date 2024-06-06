package controller.client.cart;

import model.Account;
import model.OrderDetail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "CartControll", value = "/CartControll")
public class CartControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/LoginControll");
        } else {
            Object obj = session.getAttribute("cart");
            double total = 0;

            if (obj != null) {
                Map<Integer, OrderDetail> cartTemporary = (Map<Integer, OrderDetail>) obj;

                // Tính tổng giá trị của giỏ hàng
                for (Map.Entry<Integer, OrderDetail> entry : cartTemporary.entrySet()) {
                    OrderDetail orderDetail = entry.getValue();

                    // Cập nhật giá của từng sản phẩm trong giỏ hàng
                    double price = orderDetail.getProduct().getPrice() * orderDetail.getQuantity();
                    orderDetail.setPrice(price);
                    total += price;
                }

                // Cập nhật lại giỏ hàng trong session
                session.setAttribute("cart", cartTemporary);
            }

            // Đặt thuộc tính 'total' cho request để hiển thị trong JSP
            request.setAttribute("total", total);

            // Chuyển hướng sang trang giỏ hàng
            request.getRequestDispatcher("/WEB-INF/client/cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
