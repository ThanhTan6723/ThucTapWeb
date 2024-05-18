package controller.admin.product;

import java.io.IOException;
import java.nio.file.Path;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.ProductDAO;
import model.Account;
import model.Category;
import model.Product;
import model.Provider;

@WebServlet(name = "EditProductControll", value = "/EditProductControll")
public class EditProductControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Category> cateList = ProductDAO.getListCategory();
		request.setAttribute("catelist", cateList);
		List<Provider> providerList = ProductDAO.getListProvider();
		request.setAttribute("providerList",providerList);
		String pid = request.getParameter("id");
		int product_id = Integer.parseInt(pid);
		Product product = ProductDAO.getProductById(product_id);
		request.setAttribute("product", product);
		request.getRequestDispatcher("WEB-INF/admin/edit-product.jsp").forward(request, response);

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");

		String product_id = request.getParameter("product-id");
		String product_name = request.getParameter("product-name");
		String product_price = request.getParameter("product-price");
/*
		Path path = request.getPath("product-image");
*/

		String product_image = request.getParameter("product-image");
		String product_desc = request.getParameter("product-desc");
		String product_cate = request.getParameter("product-cate");
		System.out.println(product_cate);
		String product_quantity = request.getParameter("product-quantity");
		String product_priceImport = request.getParameter("product-priceImport");
		String product_weight = request.getParameter("product-weight");
		String product_provider = request.getParameter("product-provider");
		String product_NSX = request.getParameter("product-NSX");
		String product_HSD = request.getParameter("product-HSD");
		Category category = new Category(Integer.parseInt(product_cate));
		System.out.println(category.toString());
		Provider provider = new Provider(Integer.parseInt(product_provider));
		System.out.println("provider:"+provider);
		Product p = new Product(Integer.parseInt(product_id), product_name,Double.parseDouble(product_price),product_image,
				product_desc,category,Integer.parseInt(product_quantity),Double.parseDouble(product_priceImport),Double.parseDouble(product_weight),new Account(1),provider,product_NSX,product_HSD);
		ProductDAO.updateProduct(p);
		response.sendRedirect( "/LoadProductsPage");
	}	}
