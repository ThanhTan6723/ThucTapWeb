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

@WebServlet("/DeleteOrderControll")
public class DeleteOrderControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		String key = request.getParameter("key");
		int k = Integer.parseInt(key);
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("cart");

		if (obj != null) {
			Map<Integer, OrderDetail> map = (Map<Integer, OrderDetail>) obj;
			map.remove(k);

			int sizeCart = (int) session.getAttribute("size");
			sizeCart-=1;
			session.setAttribute("size", sizeCart);
			session.setAttribute("cart", map);

			double totalAmount = map.values().stream().mapToDouble(od -> od.getQuantity() * od.getProduct().getPrice()).sum();

			// Prepare the JSON response
			Gson gson = new Gson();
			String jsonResponse = gson.toJson(new Response(sizeCart, totalAmount));

			response.getWriter().write(jsonResponse);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private class Response {
		private int sizeCart;
		private double totalAmount;

		public Response(int sizeCart, double totalAmount) {
			this.sizeCart = sizeCart;
			this.totalAmount = totalAmount;
		}

		// Getters and setters (if needed)
	}
}

