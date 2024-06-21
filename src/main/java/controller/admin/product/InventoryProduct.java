package controller.admin.product;

import dao.admin.ProductAdminDAO;
import model.Batch;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "InventoryProduct", value = "/InventoryProduct")
public class InventoryProduct extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 4; // Số bản ghi trên mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        List<Product> listInventory = ProductAdminDAO.getListProducts();
        int totalRecords = listInventory.size();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        Map<Integer, Integer> productTotalQuantities = new HashMap<>();
        Map<Integer, Integer> productCurrentQuantities = new HashMap<>();
        Map<Integer, Integer> productExpiredCurrentQuantities = new HashMap<>();
        Map<Integer, Integer> pAlmostExpired = new HashMap<>();
        Map<Integer, Integer> pStillExpired = new HashMap<>();

        for (int i = 0; i < listInventory.size(); i++) {
            Product product = listInventory.get(i);
            product = ProductAdminDAO.getProductWithBatchesById(product.getId());

            int totalQuantity = 0;
            int currentQuantity = 0;
            for (Batch batch : product.getBatches()) {
                totalQuantity += batch.getQuantity();
                currentQuantity += batch.getCurrentQuantity();
            }
            productTotalQuantities.put(product.getId(), totalQuantity);
            productCurrentQuantities.put(product.getId(), currentQuantity);
            listInventory.set(i, product);
        }

        for (int i = 0; i < listInventory.size(); i++) {
            Product product = listInventory.get(i);
            product = ProductAdminDAO.getProductStillExpiredById(product.getId());
            int totalQuantities = 0;
            for (Batch batch : product.getBatches()) {
                totalQuantities += batch.getCurrentQuantity();
            }
            pStillExpired.put(product.getId(), totalQuantities);
            listInventory.set(i, product);
        }

        for (int i = 0; i < listInventory.size(); i++) {
            Product product = listInventory.get(i);
            product = ProductAdminDAO.getProductExpiredById(product.getId());

            int expiredCurrentQuantity = 0;
            for (Batch batch : product.getBatches()) {
                expiredCurrentQuantity += batch.getCurrentQuantity();
            }
            productExpiredCurrentQuantities.put(product.getId(), expiredCurrentQuantity);

            listInventory.set(i, product);
        }

        for (int i = 0; i < listInventory.size(); i++) {
            Product product = listInventory.get(i);
            product = ProductAdminDAO.getProductAlmostExpiredById(product.getId());
            int almostExpiredCurrentQuantity = 0;
            for (Batch batch : product.getBatches()) {
                almostExpiredCurrentQuantity += batch.getCurrentQuantity();
            }
            pAlmostExpired.put(product.getId(), almostExpiredCurrentQuantity);
            listInventory.set(i, product);
        }
        String pageParam = request.getParameter("page");
        int page = 1; // Mặc định là trang 1
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                // Nếu tham số không phải là số, giữ nguyên giá trị mặc định là 1
            }
        }
        List<Product> productListForPage = getProductListForPage(listInventory, page);

        request.setAttribute("listInventory", productListForPage);
        request.setAttribute("productTotalQuantities", productTotalQuantities);
        request.setAttribute("productCurrentQuantities", productCurrentQuantities);
        request.setAttribute("productExpiredCurrentQuantities", productExpiredCurrentQuantities);
        request.setAttribute("pAlmostExpired", pAlmostExpired);
        request.setAttribute("pStillExpired", pStillExpired);

        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            request.getRequestDispatcher("/WEB-INF/admin/inventory-product-table.jsp").forward(request, response);
        } else {
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/WEB-INF/admin/inventory-product.jsp").forward(request, response);
        }

    }
    private List<Product> getProductListForPage(List<Product> listInventory, int page) {
        int startIndex = (page - 1) * RECORDS_PER_PAGE;
        int endIndex = Math.min(startIndex + RECORDS_PER_PAGE, listInventory.size());
        return listInventory.subList(startIndex, endIndex);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}