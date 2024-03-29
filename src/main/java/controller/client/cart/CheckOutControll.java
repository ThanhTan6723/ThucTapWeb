package controller.client.cart;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Account;
import model.OrderDetail;

@WebServlet("/CheckOutControll")
public class CheckOutControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		HttpSession session = request.getSession();

		Account account = (Account) session.getAttribute("account");
		Object obj = session.getAttribute("cart");
		Map<Integer, OrderDetail> map = (Map<Integer, OrderDetail>) obj;
		System.out.println("map: " + map);

		if (account == null) {
			response.sendRedirect(request.getContextPath() + "/LoginControll");
			return;
		} else {
			Set<Integer> key = map.keySet();
			double ship = 0;
			double total = 0;
			for (Integer k : key) {
				total += map.get(k).getPrice();
			}
			if (total >= 80) {
				request.setAttribute("ship", ship);
				request.setAttribute("sum", total + ship);

			} else {
				ship = 8;
				request.setAttribute("ship", ship);
				request.setAttribute("sum", total + ship);
			}
			request.setAttribute("total", total);
			request.setAttribute("name", account.getName());
			request.setAttribute("email", account.getEmail());
			request.setAttribute("phone", account.getTelephone());
		}

		request.getRequestDispatcher("/client/checkout.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
