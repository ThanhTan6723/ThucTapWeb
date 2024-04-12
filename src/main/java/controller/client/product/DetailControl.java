package controller.client.product;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.ProductDAO;
import model.Category;
import model.Product;

@WebServlet("/DetailControl")
public class DetailControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String productId = request.getParameter("pid");
		int pid=Integer.parseInt(productId);
		Product product = ProductDAO.getProductById(pid);
        assert product != null;
        int category_id = product.getCategory().getId();
		List<Product> relativeProduct = ProductDAO.relativeProduct(category_id);
		System.out.println(relativeProduct.toString());
        request.setAttribute("relativeProduct",relativeProduct);
		request.setAttribute("detail", product);
		request.getRequestDispatcher("/WEB-INF/client/product-detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
