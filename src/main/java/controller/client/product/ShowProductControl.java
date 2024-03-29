package controller.client.product;

import java.io.IOException;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.ProductDAO;
import model.Product;

@WebServlet("/ShowProductControl")
public class ShowProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		try {
		    String sort = "";
		    sort = request.getParameter("sort");
		    if (sort == null) {
		        sort = "id-asc";
		    }

		    int id = 0;
		    if (request.getParameter("cid") != null) {
		        id = Integer.parseInt(request.getParameter("cid"));
		    }
		    
		        StringTokenizer s = new StringTokenizer(sort, "-");
		        String sortName = s.nextToken();
		        String type = s.nextToken();
		        
		        List<Product> list = ProductDAO.pagingProduct(id, sortName, type);
		        
				request.setAttribute("sort", sort);
				request.setAttribute("listProducts", list);
				request.setAttribute("cid", id);
		  		} catch (Exception e) {
		    e.printStackTrace();
		}

		request.getRequestDispatcher("/client/menu.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}