package controller.client.cart;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import model.OrderDetail;

@WebServlet("/IncreaseQControll")
public class IncreaseQuantityControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String key = request.getParameter("key");
		int k = Integer.parseInt(key);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		HttpSession session = request.getSession();
		Object obj = session.getAttribute("cart");
		if (obj != null) {
			Map<Integer, OrderDetail> map = (Map<Integer, OrderDetail>) obj;
			OrderDetail orderDetail = map.get(k);
			orderDetail.setQuantity(orderDetail.getQuantity() + 1);
			map.put(k, orderDetail);
			session.setAttribute("cart", map);

			// Calculate the updated total price for the item and the total cart amount
			double totalPrice = (orderDetail.getQuantity() * orderDetail.getProduct().getPrice());
			double totalAmount = map.values().stream().mapToDouble(od -> (od.getQuantity() * od.getProduct().getPrice())).sum();

			// Prepare the JSON response
			Gson gson = new Gson();
			String jsonResponse = gson.toJson(new Response(orderDetail.getQuantity(), totalPrice, totalAmount));

			response.getWriter().write(jsonResponse);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private class Response {
		private int quantity;
		private double totalPrice;
		private double totalAmount;

		public Response(int quantity, double totalPrice, double totalAmount) {
			this.quantity = quantity;
			this.totalPrice = totalPrice;
			this.totalAmount = totalAmount;
		}

		// Getters and setters (if needed)
	}
}