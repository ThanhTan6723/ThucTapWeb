package controller.client.product;

import java.io.IOException;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.client.IndexDAO;
import dao.client.ProductDAO;
import model.Product;

@WebServlet("/ShowProductControl")
public class ShowProductControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try {

            String sort = "";
            sort = request.getParameter("sort");
            if (sort == null) {
                sort = "id-asc";
            }

            int id = 0;
            if (request.getParameter("cid") != null) {
                id = Integer.parseInt(request.getParameter("cid"));
            }
            String indexPage = request.getParameter("index");
            if(indexPage==null){
                indexPage="1";
            }
            int index = Integer.parseInt(indexPage);
            ProductDAO dao = new ProductDAO();
            int count = dao.getTotalProduct(id);
            int endPage;
            endPage = count/8;
            if (count%8 != 0) {
                endPage++;
            }
            StringTokenizer s = new StringTokenizer(sort, "-");
            String sortName = s.nextToken();
            String type = s.nextToken();

            List<Product> list = ProductDAO.pagingProduct(id, index,sortName, type);


            request.setAttribute("sort", sort);
            request.setAttribute("listProducts", list);


            request.setAttribute("cid", id);

            request.setAttribute("endPage", endPage);
            request.setAttribute("tag",index);
            String paginationHtml = "<div class=\"pagination\">";

// Nếu có trang trước đó, thêm nút Previous
            if (index > 1) {
                paginationHtml += "<a href=\"/ShowProductControl?index=" + (index - 1) + "\">Previous</a>";
            }

// Hiển thị các trang nút bấm
            for (int i = 1; i <= endPage; i++) {
                if (i == index) {
                    paginationHtml += "<span class=\"current\">" + i + "</span>";
                } else {
                    paginationHtml += "<a href=\"/ShowProductControl?index=" + i + "\">" + i + "</a>";
                }
            }

// Nếu có trang tiếp theo, thêm nút Next
            if (index < endPage) {
                paginationHtml += "<a href=\"/ShowProductControl?index=" + (index + 1) + "\">Next</a>";
            }

            paginationHtml += "</div>";

            // Đảm bảo chỉ trả về dữ liệu sản phẩm và phân trang dưới dạng JSON
            String productsJson = new Gson().toJson(list); // list là danh sách sản phẩm
            String paginationJson = new Gson().toJson(paginationHtml); // paginationHtml là mã HTML của phân trang

            // Tạo một đối tượng JSON để chứa dữ liệu sản phẩm và phân trang
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("products", productsJson); // Thêm danh sách sản phẩm vào JSON response
            jsonResponse.addProperty("pagination", paginationJson); // Thêm mã HTML của phân trang vào JSON response
// Thêm totalPages vào đối tượng JSON
            jsonResponse.addProperty("totalPages", endPage);
            // Gửi dữ liệu về client dưới dạng JSON
            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }


        List<Product> listRandProduct = IndexDAO.listRandProduct();
        request.setAttribute("listRandProduct",listRandProduct);
        List<Product> listSale = IndexDAO.getTop8();
        request.setAttribute("listSale",listSale);
        request.getRequestDispatcher("/WEB-INF/client/menu.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}