package controller.admin.orders;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.OrderDAO;
import model.OrderDetail;

@WebServlet(name = "BillDetailControll",value = "/BillDetailControll")
public class BillDetailControll extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String id = request.getParameter("id");
        List<OrderDetail> listDetail = OrderDAO.getOrderDetailByBid(Integer.parseInt(id));
        int sumQ = OrderDAO.getQuantityWithOderId(Integer.parseInt(id));

        System.out.println(listDetail);
        System.out.println("SumQ: " + sumQ);

        request.setAttribute("listBillDetails", listDetail);
        request.setAttribute("sumQ", sumQ);
        request.getRequestDispatcher("/WEB-INF/admin/bill-detail.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}

