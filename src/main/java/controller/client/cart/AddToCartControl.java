package controller.client.cart;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.ProductDAO;
import model.Account;
import model.OrderDetail;
import model.Product;

@WebServlet("/AddToCartControll")
public class AddToCartControl extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		HttpSession session = request.getSession();

		String productId = request.getParameter("pid");
		int pid = Integer.parseInt(productId);
		System.out.println("pid"+pid);

		Account account = (Account) session.getAttribute("account");
		// if not found account
		if (account == null) {
			response.sendRedirect(request.getContextPath() + "/LoginControll");
		} else {
			// if find account
			int quantity = 1;
			Product product = ProductDAO.getProductById(pid);
			Object obj = session.getAttribute("cart");
			System.out.println("obj: " + obj);
			String getQuantity = request.getParameter("quantity");
			System.out.println("số lượng "+getQuantity);

			if (getQuantity != null) {
				quantity = Integer.parseInt(getQuantity);
			}
			if (obj == null) {
				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setProduct(product);
				orderDetail.setQuantity(quantity);
				orderDetail.setPrice(product.getPrice() * quantity);
				Map<Integer, OrderDetail> map = new HashMap<>();
				map.put(pid, orderDetail);
				System.out.println("map"+map);
				session.setAttribute("cart", map);

			} else {
				Map<Integer, OrderDetail> map = (Map<Integer, OrderDetail>) obj;
				System.out.println();
				OrderDetail orderDetail = map.get(pid);
				System.out.println("od: " + orderDetail);
				if (orderDetail == null) {
					orderDetail = new OrderDetail();
					orderDetail.setProduct(product);
					orderDetail.setQuantity(quantity);
					orderDetail.setPrice(product.getPrice() * quantity);
					map.put(pid, orderDetail);
					System.out.println("map"+map);
				} else {
					orderDetail.setQuantity(orderDetail.getQuantity() + quantity);
				}
				session.setAttribute("cart", map);

			}
			Map<Integer, OrderDetail> m = (Map<Integer, OrderDetail>) session.getAttribute("cart");
			int sizeCart = m.size();
			System.out.println("sizeCart"+sizeCart);
			session.setAttribute("size", sizeCart);
			request.getRequestDispatcher("CartControll").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
