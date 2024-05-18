package controller.admin.product;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.client.ProductDAO;
import model.Category;
import model.Product;

@MultipartConfig
@WebServlet("/AddProductControll")
public class AddProductControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Category> cateList = ProductDAO.getListCategory();
		request.setAttribute("catelist", cateList);
		request.getRequestDispatcher("/admin/add-product.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");

		String product_id = request.getParameter("product-id");
		String product_category = request.getParameter("product-cate");
		String product_name = request.getParameter("product-name");
		String product_price = request.getParameter("product-price");
		String product_desc = request.getParameter("product-desc");

/*
		Category category = new Category(Integer.parseInt(product_category), product_name);
		Product p = new Product(Integer.parseInt(product_id), product_name, Double.parseDouble(product_price), null,
				product_desc, category);
*/

/*		Part part = request.getParameter("product-image");
		String realPath = request.getServletContext().getRealPath("/images");
		String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();

		if (!Files.exists(Path.of(realPath))) {
			Files.createDirectory(Path.of(realPath));
		}
		part.write(realPath + "/" + filename);
		p.setImage("images/" + filename);*/
/*		ProductDAO.insertProduct(p);*/
		HttpSession session = request.getSession();
		String sessionID = ";jsessionid=" + session.getId();
		response.sendRedirect(request.getContextPath() + "/ListProductsControll" + sessionID);
	}

}
