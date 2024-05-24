package controller.client.product;

import java.io.IOException;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.admin.ProductAdminDAO;
import dao.client.ProductDAO;
import model.*;

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
		System.out.println("id ne"+pid);
		Product product = ProductDAO.getProductById(pid);
    
        assert product != null;
        int category_id = product.getCategory().getId();
        List<Product> relativeProduct = ProductDAO.relativeProduct(category_id);
        request.setAttribute("relativeProduct", relativeProduct);
        // Tạo một bản sao của đối tượng Product
        product.setId(product.getId());
        product.setName(product.getName());
  
		product.setPrice(product.getPrice());
		product.setImage(product.getImage());
		product.setDescription(product.getDescription());
		product.setCategory(product.getCategory());
		product.setImages(product.getImages());
        List<Image> listImageProduct = ProductDAO.listImageProduct(product.getId());
		String nameCategory = ProductDAO.getCategoryById(product.getCategory().getId());
		List<Batch> listBatch = ProductDAO.getListBatchById(product.getId());
		List<Product> listInventory = ProductAdminDAO.getListProducts();
		Map<Integer, Integer> productCurrentQuantities = new HashMap<>();

		for (int i = 0; i < listInventory.size(); i++) {
			Product p = listInventory.get(i);
			product = ProductAdminDAO.getProductWithBatchesById(product.getId());

			int totalQuantity = 0;
			int currentQuantity = 0;
			for (Batch batch : product.getBatches()) {
				totalQuantity += batch.getQuantity();
				currentQuantity += batch.getCurrentQuantity();
			}
			productCurrentQuantities.put(p.getId(), currentQuantity);

			listInventory.set(i, p);
		}
		System.out.println("danh sach hang"+listBatch.toString());
		request.setAttribute("productCurrentQuantities", productCurrentQuantities);
		request.setAttribute("listImageProduct",listImageProduct);
		request.setAttribute("nameCategory",nameCategory);
		request.setAttribute("detail", product);
		request.setAttribute("listBatch",listBatch);
		request.getRequestDispatcher("/WEB-INF/client/product-detail.jsp").forward(request, response);
	}


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
