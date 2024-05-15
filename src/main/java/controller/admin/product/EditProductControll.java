package controller.admin.product;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.ProductDAO;
import model.Category;
import model.Product;

@WebServlet("/EditProductControll")
public class EditProductControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Category> cateList = ProductDAO.getListCategory();
		request.setAttribute("catelist", cateList);
        String pid = request.getParameter("id");
        int product_id = Integer.parseInt(pid);
        Product product = ProductDAO.getProductById(product_id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/admin/edit-product.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");

		String product_id = request.getParameter("product-id");
		String product_cate = request.getParameter("product-cate");
		String product_name = request.getParameter("product-name");
		String product_price = request.getParameter("product-price");
		String product_desc = request.getParameter("product-desc");
		String product_image = request.getParameter("product-image");
		Category category = new Category(Integer.parseInt(product_cate),product_name);
/*		Product p = new Product(Integer.parseInt(product_id), product_name,Double.parseDouble(product_price),product_image,
	    		 product_desc,category);
		ProductDAO.updateProduct(p);*/
		HttpSession session = request.getSession();
		String sessionID = ";jsessionid="+session.getId();
		response.sendRedirect(request.getContextPath() + "/ListProductsControll"+sessionID);
	}	}


