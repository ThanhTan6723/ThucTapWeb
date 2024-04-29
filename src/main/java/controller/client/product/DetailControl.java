package controller.client.product;

import java.io.IOException;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.ProductDAO;
import model.Category;
import model.Image;
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
        request.setAttribute("relativeProduct",relativeProduct);
		// Tạo một bản sao của đối tượng Product
		product.setId(product.getId());
		product.setName(product.getName());
        product.setPrice(product.getPrice());
		System.out.println(product.getPrice());
		product.setPrice(product.getPrice());
		product.setImage(product.getImage());
		product.setDescription(product.getDescription());
		product.setCategory(product.getCategory());
        String categoryNameById = ProductDAO.getCategoryById(product.getCategory().getId());
		System.out.println(categoryNameById);
		product.setQuantity(product.getQuantity());
		product.setDateOfImporting(product.getDateOfImporting());
		product.setExpriredDay(product.getExpriredDay());
		product.setWeight(product.getWeight());
		product.setImages(product.getImages());
        List<Image> listImageProduct = ProductDAO.listImageProduct(product.getId());
		System.out.println(listImageProduct);
		request.setAttribute("listImageProduct",listImageProduct);
		request.setAttribute("nameCategory",categoryNameById);
		request.setAttribute("detail", product);
		request.getRequestDispatcher("/WEB-INF/client/product-detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
