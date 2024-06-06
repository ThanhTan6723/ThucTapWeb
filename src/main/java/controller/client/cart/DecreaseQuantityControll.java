package controller.client.cart;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.OrderDetail;
@WebServlet("/DecreaseQControl")
public class DecreaseQuantityControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String key = request.getParameter("key");

		int k = Integer.parseInt(key);

		HttpSession session = request.getSession();
		Object obj = session.getAttribute("cart");
		if (obj != null) {
			Map<Integer, OrderDetail> map = (Map<Integer, OrderDetail>) obj;
			OrderDetail orderDetail = map.get(k);
			if (orderDetail != null && orderDetail.getQuantity() > 1) {
				orderDetail.setQuantity(orderDetail.getQuantity() - 1);
				session.setAttribute("cart", map);
				response.getWriter().write("success");
			} else {
				response.getWriter().write("quantity cannot be less than 1");
			}
		} else {
			response.getWriter().write("cart not found");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
