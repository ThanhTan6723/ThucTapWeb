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
            System.out.println("sort "+sort);
            if (sort == null || sort.isEmpty()) {
                sort = "id-asc";
                System.out.println("sort "+sort);
            }

            int id = 0;
            if (request.getParameter("cid") != null) {
                id = Integer.parseInt(request.getParameter("cid"));
            }

            ProductDAO dao = new ProductDAO();
            StringTokenizer s = new StringTokenizer(sort, "-");
            System.out.println(s.toString());
            String sortName = s.nextToken();
            System.out.println(sortName);
            String type = s.nextToken();
            System.out.println(type);
            String pageParam = request.getParameter("page");
            int page = 1; // Mặc định là trang 1
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                }
            }

            boolean applyFilter = false;
            String category = request.getParameter("category");
            String priceSort = request.getParameter("price_sort");
            String nameSort = request.getParameter("name_sort");
            String priceFrom = request.getParameter("price_from");
            String priceTo = request.getParameter("price_to");
            String provider = request.getParameter("provider");

            if ((category != null && !category.isEmpty()) ||
                    (priceSort != null && !priceSort.isEmpty()) ||
                    (nameSort != null && !nameSort.isEmpty()) ||
                    (priceFrom != null && !priceFrom.isEmpty()) ||
                    (priceTo != null && !priceTo.isEmpty()) ||
                    (provider != null && !provider.isEmpty())) {
                applyFilter = true;
            }


            List<Product> productListForPage;
            System.out.println(applyFilter);
            if (!applyFilter) {
                List<Product> list = ProductDAO.pagingProduct(id, sortName, type);
                productListForPage = getProductListForPage(list, page);
                request.setAttribute("listProducts", productListForPage);
                int endPage = (int) Math.ceil((double) list.size() / RECORDS_PER_PAGE);
                request.setAttribute("endPage", endPage);

            } else {
                // Xử lý lỗi nếu các tham số là null hoặc rỗng
                double priceFromVal = (priceFrom != null && !priceFrom.isEmpty()) ? Double.parseDouble(priceFrom) : 0;
                double priceToVal = (priceTo != null && !priceTo.isEmpty()) ? Double.parseDouble(priceTo) : Double.MAX_VALUE;
                int categoryVal = (category != null && !category.isEmpty()) ? Integer.parseInt(category) : 0;
                int providerVal = (provider != null && !provider.isEmpty()) ? Integer.parseInt(provider) : 0;

                List<Product> listLoc = ProductDAO.getFilteredProducts(categoryVal, providerVal, priceFromVal, priceToVal, nameSort, priceSort);
                productListForPage = getProductListForPage(listLoc, page);
                request.setAttribute("listProducts", productListForPage);
                int endPage = (int) Math.ceil((double) listLoc.size() / RECORDS_PER_PAGE);
                request.setAttribute("endPage", endPage);
            }
            // Đặt các giá trị bộ lọc trong request
            request.setAttribute("sort", sort);
            request.setAttribute("cid", id);
            request.setAttribute("category", category);
            request.setAttribute("price_sort", priceSort);
            request.setAttribute("name_sort", nameSort);
            request.setAttribute("price_from", priceFrom);
            request.setAttribute("price_to", priceTo);
            request.setAttribute("provider", provider);

            // Xử lý forward chỉ một lần
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                System.out.println("Forwarding to /WEB-INF/client/product-list.jsp");
                List<Product> listSale = IndexDAO.getTop8();
                System.out.println(listSale.toString());
                request.setAttribute("listSale", listSale);
                request.getRequestDispatcher("/WEB-INF/client/product-list.jsp").forward(request, response);
            } else {
                System.out.println("Forwarding to /WEB-INF/client/menu.jsp");
                List<Product> listRandProduct = IndexDAO.listRandProduct();
                request.setAttribute("listRandProduct", listRandProduct);
                List<Product> listSale = IndexDAO.getTop8();
                System.out.println(listSale.toString());
                request.setAttribute("listSale", listSale);
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
