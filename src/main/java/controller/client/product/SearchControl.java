package controller.client.product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.AccessDAO;
import dao.client.ProductDAO;
import model.Product;

@WebServlet("/SearchControl")
public class SearchControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

        String txtSearch = request.getParameter("query");
        if (txtSearch != null && !txtSearch.isEmpty()) {

            List<Product> list = AccessDAO.searchByName(txtSearch);
            System.out.println("list search: "+list);
                 PrintWriter out = response.getWriter();
                for (Product o:list){
                   out.println("<div class=\"col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat\">\n" +
                           "\t\t\t\t\t\t\t<div class=\"featured__item\">\n" +
                           "\t\t\t\t\t\t\t\t<div class=\"featured__item__pic set-bg\" >\n" +
                           "\t\t\t\t\t\t\t\t\t<a href=\"/DetailControl?pid="+o.getId()+"\">\n" +
                           "\t\t\t\t\t\t\t\t\t\t<img src=\""+o.getImage()+"\" alt=\""+o.getName()+"\">\n" +
                           "\t\t\t\t\t\t\t\t\t</a>\n" +
                           "\t\t\t\t\t\t\t\t</div>\n" +
                           "\t\t\t\t\t\t\t\t<div class=\"featured__item__text\">\n" +
                           "\t\t\t\t\t\t\t\t\t<a class=\"product-name\" href=\"/DetailControl?pid="+o.getId()+"\" style=\"color: black\">\n" +
                           "\t\t\t\t\t\t\t\t\t\t\t"+o.getName()+"</a>\n" +
                           "\t\t\t\t\t\t\t\t\t<h5>"+o.getPrice()+"</h5>\n" +
                           "\t\t\t\t\t\t\t\t</div>\n" +
                           "\t\t\t\t\t\t\t\t<div class=\"text-center\">\n" +
                           "\t\t\t\t\t\t\t\t\t<c:url var=\"addToCart\" value=\"/AddToCartControll\"></c:url>\n" +
                           "\t\t\t\t\t\t\t\t\t<form action=\"/AddToCartControll?pid="+o.getId()+"\" method=\"post\" enctype=\"multipart/form-data\">\n" +
                           "\t\t\t\t\t\t\t\t\t\t<button\n" +
                           "\t\t\t\t\t\t\t\t\t\t\t\tstyle=\"padding: 10px 23px; border-radius: 5px; border: none; background-color: #7fad39; font-weight: 700\"\n" +
                           "\t\t\t\t\t\t\t\t\t\t\t\ttype=\"submit\">\n" +
                           "\t\t\t\t\t\t\t\t\t\t\t<a href=\"/DetailControl?pid="+o.getId()+"\" style=\"color:#ffffff\">\n" +
                           "\t\t\t\t\t\t\t\t\t\t\t\tMUA NGAY</a>\n" +
                           "\t\t\t\t\t\t\t\t\t\t</button>\n" +
                           "\t\t\t\t\t\t\t\t\t</form>\n" +
                           "\t\t\t\t\t\t\t\t</div>\n" +
                           "\t\t\t\t\t\t\t</div>\n" +
                           "\t\t\t\t\t\t</div>");
                }
            }else{

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

            List<Product> listAll = ProductDAO.pagingProduct(id, index,sortName, type);
            System.out.println("list search: "+listAll);
            PrintWriter out = response.getWriter();
            for (Product o:listAll){
                out.println("<div class=\"col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat\">\n" +
                        "\t\t\t\t\t\t\t<div class=\"featured__item\">\n" +
                        "\t\t\t\t\t\t\t\t<div class=\"featured__item__pic set-bg\" >\n" +
                        "\t\t\t\t\t\t\t\t\t<a href=\"/DetailControl?pid="+o.getId()+"\">\n" +
                        "\t\t\t\t\t\t\t\t\t\t<img src=\""+o.getImage()+"\" alt=\""+o.getName()+"\">\n" +
                        "\t\t\t\t\t\t\t\t\t</a>\n" +
                        "\t\t\t\t\t\t\t\t</div>\n" +
                        "\t\t\t\t\t\t\t\t<div class=\"featured__item__text\">\n" +
                        "\t\t\t\t\t\t\t\t\t<a class=\"product-name\" href=\"/DetailControl?pid="+o.getId()+"\" style=\"color: black\">\n" +
                        "\t\t\t\t\t\t\t\t\t\t\t"+o.getName()+"</a>\n" +
                        "\t\t\t\t\t\t\t\t\t<h5>"+o.getPrice()+"</h5>\n" +
                        "\t\t\t\t\t\t\t\t</div>\n" +
                        "\t\t\t\t\t\t\t\t<div class=\"text-center\">\n" +
                        "\t\t\t\t\t\t\t\t\t<c:url var=\"addToCart\" value=\"/AddToCartControll\"></c:url>\n" +
                        "\t\t\t\t\t\t\t\t\t<form action=\"/AddToCartControll?pid="+o.getId()+"\" method=\"post\" enctype=\"multipart/form-data\">\n" +
                        "\t\t\t\t\t\t\t\t\t\t<button\n" +
                        "\t\t\t\t\t\t\t\t\t\t\t\tstyle=\"padding: 10px 23px; border-radius: 5px; border: none; background-color: #7fad39; font-weight: 700\"\n" +
                        "\t\t\t\t\t\t\t\t\t\t\t\ttype=\"submit\">\n" +
                        "\t\t\t\t\t\t\t\t\t\t\t<a href=\"/DetailControl?pid="+o.getId()+"\" style=\"color:#ffffff\">\n" +
                        "\t\t\t\t\t\t\t\t\t\t\t\tMUA NGAY</a>\n" +
                        "\t\t\t\t\t\t\t\t\t\t</button>\n" +
                        "\t\t\t\t\t\t\t\t\t</form>\n" +
                        "\t\t\t\t\t\t\t\t</div>\n" +
                        "\t\t\t\t\t\t\t</div>\n" +
                        "\t\t\t\t\t\t</div>");
            }

        }
        request.setAttribute("txt",txtSearch);


        // Chuyển hướng đến trang menu.jsp (kể cả khi không tìm thấy sản phẩm).

    }

protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
