package controller.client.cart;

import model.Account;
import model.OrderDetail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Map;
import java.util.Set;

@WebServlet(name = "CartControll", value = "/CartControll")
public class CartControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        Object obj = session.getAttribute("cart");

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/LoginControll");
        } else {
            double total = 0;
            if (obj != null) {
                Map<Integer, OrderDetail> cartTemporary = (Map<Integer, OrderDetail>) obj;
                Set<Integer> key = cartTemporary.keySet();
                for (Integer k : key) {
                    OrderDetail orderDe = cartTemporary.get(k);
                    //price with number of products
                    orderDe.setPrice(orderDe.getQuantity() * orderDe.getProduct().getPrice());
                    cartTemporary.put(k, orderDe);
                }
                session.setAttribute("cart", cartTemporary);
                for (Map.Entry<Integer, OrderDetail> entry : cartTemporary.entrySet()) {
                    OrderDetail oderDetail = entry.getValue();
                    // total price
                    total += oderDetail.getPrice();
                }
            }
            request.setAttribute("total", total);
            request.getRequestDispatcher("/WEB-INF/client/cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}