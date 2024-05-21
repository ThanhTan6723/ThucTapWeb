package controller.admin.index;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.admin.AdminDAO;

@WebServlet("/IndexAdminControll")
public class IndexAdminControll extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		Map<String, String> map = new HashMap<String, String>();

		map.put("sumOrder", AdminDAO.getSumOrder());
		map.put("sumPrice", AdminDAO.getSumPrice());
		map.put("sumPriceType1", AdminDAO.getSumType("1"));
		map.put("sumPriceType2", AdminDAO.getSumType("2"));
		map.put("sumPriceType3", AdminDAO.getSumType("3"));
		map.put("ratio1", AdminDAO.getRatio("1"));
		map.put("ratio2", AdminDAO.getRatio("2"));
		map.put("ratio3", AdminDAO.getRatio("3"));
		request.setAttribute("map", map);

		request.getRequestDispatcher("/WEB-INF/admin/index.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		doGet(request, response);
	}

}
