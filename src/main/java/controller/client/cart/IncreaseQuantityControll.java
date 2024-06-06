/*
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

@WebServlet("/IncreaseQControll")
public class IncreaseQuantityControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String key = request.getParameter("key");
		int k =Integer.parseInt(key);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("cart");
		if(obj!=null) {
			Map<Integer, OrderDetail> map = (Map<Integer, OrderDetail>) obj;
			map.get(k).setQuantity(map.get(k).getQuantity()+1);
			session.setAttribute("cart", map);
		}
		
		request.getRequestDispatcher("CartControll").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
*/
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

@WebServlet("/IncreaseQControl")
public class IncreaseQuantityControll extends HttpServlet {
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
			map.get(k).setQuantity(map.get(k).getQuantity() + 1);
			session.setAttribute("cart", map);
		}

		response.getWriter().write("success");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

