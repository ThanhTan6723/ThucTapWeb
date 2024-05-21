package controller.admin.product;

import dao.client.ProductDAO;
import model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ExpiredProduct", value = "/ExpiredProduct")
public class ExpiredProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        List<Product> list = ProductDAO.getListExpiredProduct();
        request.setAttribute("listExpiredProduct",list);
        request.getRequestDispatcher("WEB-INF/admin/expired-product.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
