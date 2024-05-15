package controller.client.order;

import java.io.IOException;
import java.time.LocalDate;
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

@WebServlet(name = "OrderControll", value = "/OrderControll")
public class OrderControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		System.out.println("Address "+address);
		String note = request.getParameter("notes");

		String status = "Order is awaiting confirmation";

		HttpSession session = request.getSession();

		Account account = (Account) session.getAttribute("account");
		System.out.println("session: " + account);

		Object obj = session.getAttribute("cart");
		Map<Integer, OrderDetail> map = (Map<Integer, OrderDetail>) obj;
		System.out.println("map: " + map);

		Set<Integer> listKeys = map.keySet();

		if (obj != null) {
			Order order = new Order();
			String date = LocalDate.now().toString();
			order.setDate(date);
			order.setAccount(account);
			order.setOrderStatus(status);
			order.setAddress(address);
			order.setOrderNotes(note);
			System.out.println(order);
			OrderDAO.insertOrder(order);
			OrderDAO.setCurrentIdBill(order);
			double total = 0;
			for (Entry<Integer, OrderDetail> entry : map.entrySet()) {
				OrderDetail orderDetail = entry.getValue();
				orderDetail.setOrder(order);
				System.out.println(orderDetail);

				OrderDAO.insertOrderdetail(orderDetail);

				total += orderDetail.getPrice();

			}
			order.setTotalMoney(total);
			OrderDAO.updateOrders(order);

			map.clear();
			session.setAttribute("cart", map);
			session.setAttribute("size", 0);
			response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");
			return;

		}

		request.getRequestDispatcher("/WEB-INF/client/cart.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
