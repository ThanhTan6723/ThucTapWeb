package controller.client.cart;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.OrderDAO;
import model.Account;
import model.Order;
import model.OrderDetail;
import model.Product;

@WebServlet("/CartControll")
public class CartControl extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
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
					orderDe.setPrice(orderDe.getQuantity()*orderDe.getProduct().getPrice());
					cartTemporary.put(k, orderDe);
				}
				session.setAttribute("cart", cartTemporary);
				for (Entry<Integer, OrderDetail> entry : cartTemporary.entrySet()) {
					OrderDetail oderDetail = entry.getValue();
					// total price
					total += oderDetail.getPrice();
				}
			}
			request.setAttribute("total", total);
			request.getRequestDispatcher("/client/cart.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
