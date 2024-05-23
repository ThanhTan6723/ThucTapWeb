package controller.admin.product;

import dao.client.ProductDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteExpiredProduct", value = "/DeleteExpiredProduct")
public class DeleteExpiredProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pid = request.getParameter("id");
        ProductDAO.removeProduct(Integer.parseInt(pid));
        response.sendRedirect("ExpiredProduct");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}