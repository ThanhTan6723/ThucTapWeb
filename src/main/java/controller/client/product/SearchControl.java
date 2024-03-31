package controller.client.product;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.AccessDAO;
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
            
            if (list.isEmpty()) {
                // Nếu không tìm thấy sản phẩm, hiển thị thông báo "Không tìm thấy sản phẩm".
                request.setAttribute("message", "Không tìm thấy sản phẩm. Vui lòng chọn món khác");
                
            } else {
                // Nếu tìm thấy sản phẩm, đặt danh sách sản phẩm vào request để hiển thị.
                request.setAttribute("listProducts", list);
                request.setAttribute("query", txtSearch);
            }
        }else {
        	request.setAttribute("message1", "Vui lòng nhập từ khóa tìm kiếm");
        }

        // Chuyển hướng đến trang menu.jsp (kể cả khi không tìm thấy sản phẩm).
        request.getRequestDispatcher("/WEB-INF/client/menu.jsp").forward(request, response);
    }

protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
