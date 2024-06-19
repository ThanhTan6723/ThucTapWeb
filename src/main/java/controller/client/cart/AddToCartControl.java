package controller.client.cart;

import dao.client.ProductDAO;
import model.Account;
import model.OrderDetail;
import model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AddToCartControl", value = "/AddToCartControl")
public class AddToCartControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();

        String productId = request.getParameter("pid");
        int pid = Integer.parseInt(productId);

        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/LoginControll");
        } else {
            int quantity = 1;
            Product product = ProductDAO.getProductById(pid);
            Object obj = session.getAttribute("cart");

            String getQuantity = request.getParameter("quantity");
            if (getQuantity != null) {
                quantity = Integer.parseInt(getQuantity);
            }

            if (obj == null) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setProduct(product);
                orderDetail.setQuantity(quantity);
                orderDetail.setPrice(product.getPrice() * quantity);
                Map<Integer, OrderDetail> map = new HashMap<>();
                map.put(pid, orderDetail);
                session.setAttribute("cart", map);
            } else {
                Map<Integer, OrderDetail> map = (Map<Integer, OrderDetail>) obj;
                OrderDetail orderDetail = map.get(pid);
                if (orderDetail == null) {
                    orderDetail = new OrderDetail();
                    orderDetail.setProduct(product);
                    orderDetail.setQuantity(quantity);
                    orderDetail.setPrice(product.getPrice() * quantity);
                    map.put(pid, orderDetail);
                } else {
                    orderDetail.setQuantity(orderDetail.getQuantity() + quantity);
                }
                session.setAttribute("cart", map);
            }

            Map<Integer, OrderDetail> m = (Map<Integer, OrderDetail>) session.getAttribute("cart");
            int sizeCart = m.size();
            session.setAttribute("size", sizeCart);

            // Trả về JSON chứa kích thước giỏ hàng
            response.getWriter().write("{\"size\":" + sizeCart + "}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
}