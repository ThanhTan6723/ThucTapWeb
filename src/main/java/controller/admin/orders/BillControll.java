package controller.admin.orders;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.OrderDAO;
import model.Order;
import model.OrderDetail;

@WebServlet("/BillControll")
public class BillControll extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String status1 = "Order is awaiting confirmation";
        String status2 = "Order has been confirmed";
        String status3 = "Order is Refused";

        List<Order> listOrders = OrderDAO.getAllOrders(status1);
        List<Order> listOrdersConfirmed = OrderDAO.getAllOrders(status2);
        List<Order> listOrdersRefused = OrderDAO.getAllOrders(status3);

        HttpSession session = request.getSession();
        session.setAttribute("AllOrders", listOrders);
        session.setAttribute("OrdersConfirmed", listOrdersConfirmed);
        session.setAttribute("OrdersRefused", listOrdersRefused);
        System.out.println(listOrders);

        request.getRequestDispatcher("/WEB-INF/admin/bill.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub

    }

}
