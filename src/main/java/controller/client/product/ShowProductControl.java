package controller.client.product;

import java.io.IOException;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.client.IndexDAO;
import dao.client.ProductDAO;
import model.Product;
@WebServlet("/ShowProductControl")
public class ShowProductControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int RECORDS_PER_PAGE = 8; // Số bản ghi trên mỗi trang

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try {
            String sort = request.getParameter("sort");
            if (sort == null || sort.isEmpty()) {
                sort = "id-asc";
            }
            int categoryId = 0;
            if (request.getParameter("cid") != null && !request.getParameter("cid").isEmpty()) {
                categoryId = Integer.parseInt(request.getParameter("cid"));
            }
            StringTokenizer s = new StringTokenizer(sort, "-");
            String sortName = s.nextToken();
            String sortType = s.nextToken();

            int page = 1; // Mặc định là trang 1
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    // Log và xử lý ngoại lệ
                }
            }

            boolean applyFilter = false;
            String category = request.getParameter("category");
            String priceFrom = request.getParameter("price_from");
            String priceTo = request.getParameter("price_to");
            String provider = request.getParameter("provider");

            applyFilter = (category != null && !category.isEmpty()) ||
                    (priceFrom != null && !priceFrom.isEmpty()) ||
                    (priceTo != null && !priceTo.isEmpty()) ||
                    (provider != null && !provider.isEmpty());

            List<Product> listSale = IndexDAO.getTop8();
            List<Product> productListForPage;

            if (!applyFilter) {
                List<Product> productList = ProductDAO.pagingProduct(categoryId, sortName, sortType);
                productListForPage = getProductListForPage(productList, page);
                for(Product p:productListForPage){
                    System.out.println(p.toString());
                }
                request.setAttribute("listProducts", productListForPage);
                int endPage = (int) Math.ceil((double) productList.size() / RECORDS_PER_PAGE);
                request.setAttribute("endPage", endPage);
            } else {
                Double priceFromVal = (priceFrom != null && !priceFrom.isEmpty()) ? Double.parseDouble(priceFrom) : null;
                Double priceToVal = (priceTo != null && !priceTo.isEmpty()) ? Double.parseDouble(priceTo) : null;
                Integer categoryVal = (category != null && !category.isEmpty()) ? Integer.parseInt(category) : null;
                Integer providerVal = (provider != null && !provider.isEmpty()) ? Integer.parseInt(provider) : null;
                List<Product> filteredProducts = ProductDAO.getFilteredProducts(categoryVal, providerVal, priceFromVal, priceToVal);
                productListForPage = getProductListForPage(filteredProducts, page);
                for(Product p:productListForPage){
                    System.out.println(p.toString());
                }
                request.setAttribute("listProducts", productListForPage);
                int endPage = (int) Math.ceil((double) filteredProducts.size() / RECORDS_PER_PAGE);
                request.setAttribute("endPage", endPage);
            }
            request.setAttribute("listSale", listSale);
            request.setAttribute("sort", sort);
            request.setAttribute("cid", categoryId);
            request.setAttribute("category", category);
            request.setAttribute("price_from", priceFrom);
            request.setAttribute("price_to", priceTo);
            request.setAttribute("provider", provider);

            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                request.getRequestDispatcher("/WEB-INF/client/product-list.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/WEB-INF/client/menu.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private List<Product> getProductListForPage(List<Product> list, int page) {
        int startIndex = (page - 1) * RECORDS_PER_PAGE;
        int endIndex = Math.min(startIndex + RECORDS_PER_PAGE, list.size());
        return list.subList(startIndex, endIndex);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
