package controller.client.order;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.OrderDAO;
import model.Account;
import model.OrderDetail;

@WebServlet("/OrderPlaceControl")
public class OrderPlaceControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("account") != null) {
			Account account = (Account) session.getAttribute("account");
			int account_id = account.getId();
			List<OrderDetail> list = OrderDAO.getListOrder(account_id);
			System.out.println("List orders: "+list);
			request.setAttribute("listProductOrder", list);
		}
		request.getRequestDispatcher("/WEB-INF/client/order-placed.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
