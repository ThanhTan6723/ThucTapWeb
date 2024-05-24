<%--
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

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");


try {
String sort = request.getParameter("sort");
if (sort == null || sort.isEmpty()) {
sort = "id-asc";
}
String category = request.getParameter("category");
System.out.println(category);
if(category==null || category.isEmpty()){
category="1";
}
String priceSort = request.getParameter("price_sort");
System.out.println(priceSort);
if(priceSort==null || priceSort.isEmpty()){
priceSort="asc";
}
String nameSort = request.getParameter("name_sort");
System.out.println(nameSort);
if(nameSort==null || nameSort.isEmpty()){
nameSort="asc";
}
String priceFrom = request.getParameter("price_from");
System.out.println(priceFrom);
if(priceFrom==null || priceFrom.isEmpty()){
priceFrom="1";
}
String priceTo = request.getParameter("price_to");
System.out.println(priceTo);
if(priceTo==null || priceTo.isEmpty()){
priceTo="20";
}
String provider = request.getParameter("provider");
System.out.println(provider);
if(provider==null || provider.isEmpty()){
provider="2";
}


int id = 0;
if (request.getParameter("cid") != null) {
id = Integer.parseInt(request.getParameter("cid"));
}

ProductDAO dao = new ProductDAO();
int count = dao.getTotalProduct(id);
int endPage = (int) Math.ceil((double) count / 8);
StringTokenizer s = new StringTokenizer(sort, "-");
String sortName = s.nextToken();
String type = s.nextToken();
String pageParam = request.getParameter("page");
int page = 1; // Mặc định là trang 1
if (pageParam != null) {
try {
page = Integer.parseInt(pageParam);
} catch (NumberFormatException e) {
// Nếu tham số không phải là số, giữ nguyên giá trị mặc định là 1
}
}

/*
System.out.println(listLoc.toString());
*/
/*            List<Product> list = ProductDAO.pagingProduct(id,sortName,type);*/
List<Product> listLoc = ProductDAO.getFilteredProducts(Integer.parseInt(category),Integer.parseInt(provider),
Double.parseDouble(priceFrom),Double.parseDouble(priceTo),nameSort,priceSort);
List<Product> productListForPage = getProductListForPage(listLoc, page);

request.setAttribute("sort", sort);
request.setAttribute("listProducts", productListForPage);
request.setAttribute("cid", id);
request.setAttribute("endPage", endPage);

if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
request.getRequestDispatcher("/WEB-INF/client/product-list.jsp").forward(request, response);
} else {
List<Product> listRandProduct = IndexDAO.listRandProduct();
request.setAttribute("listRandProduct", listRandProduct);
List<Product> listSale = IndexDAO.getTop8();
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
protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
doGet(request, response);
}
}
--%>
