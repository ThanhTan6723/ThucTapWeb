package controller.admin.orders;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.mail.FetchProfile.Item;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.OrderDAO;
import model.Order;
import model.OrderDetail;
import model.Product;

@WebServlet("/BillDetailControll")
public class BillDetailControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List<Order> lists = OrderDAO.getAllOrders();
		Map<Integer, List<OrderDetail>> map = new HashMap<>();

		for (int i = 0; i < lists.size(); i++) {
			map.put(i, OrderDAO.getOrderDetailByBid(lists.get(i).getId()));
		}

		Map<Integer, Integer> sumQ = new HashMap<Integer, Integer>();

		for (int i = 0; i < lists.size(); i++) {
			sumQ.put(lists.get(i).getId(), OrderDAO.getQuantityWithOderId(lists.get(i).getId()));
		}

		System.out.println(map);
		System.out.println("Sum Q: " + sumQ);

		request.setAttribute("listBillDetails", map);
		request.setAttribute("lists", lists);
		request.setAttribute("listQ", sumQ);
		request.getRequestDispatcher("/WEB-INF/admin/bill-detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
