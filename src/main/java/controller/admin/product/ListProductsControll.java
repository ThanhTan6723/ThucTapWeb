package controller.admin.product;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.client.ProductDAO;
import model.Product;

@WebServlet("/ListProductsControll")
public class ListProductsControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Product> list = ProductDAO.getListProducts();
		Map<Integer,String > categoryNames = new HashMap<>();
        for(Product i : list){
			String nameCategory = ProductDAO.getCategoryById(i.getCategory().getId());
			categoryNames.put(i.getId(),nameCategory);
		}
		request.setAttribute("productlist", list);
		request.setAttribute("categoryNames",categoryNames);
		request.getRequestDispatcher("WEB-INF/admin/show-product.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
