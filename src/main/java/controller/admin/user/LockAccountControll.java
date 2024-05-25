package controller.admin.user;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

import dao.client.AccountDAO;
import dao.client.AccountDAO;

@WebServlet(name = "LockAccountControll", value = "/LockAccountControll")
public class LockAccountControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng các yêu cầu GET tới phương thức doPost
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Lấy các tham số từ yêu cầu
        String userId = request.getParameter("userId");
        String action = request.getParameter("action"); // Hành động có thể là "lock" hoặc "unlock"
        System.out.println(userId);

        // Kiểm tra xem các tham số userId và action có khác null không
        if (userId != null && action != null) {
            // Thực hiện hành động khóa hoặc mở khóa dựa trên tham số action
            boolean success = false;
            if (action.equals("lock")) {
                success = AccountDAO.lockAccount(Integer.parseInt(userId)); // Gọi phương thức DAO để khóa người dùng
            } else if (action.equals("unlock")) {
                success = AccountDAO.unlockAccount(Integer.parseInt(userId)); // Gọi phương thức DAO để mở khóa người dùng
            }

            // Đặt thông báo phản hồi dựa trên kết quả của hành động
            String message = success ? "Hành động thành công" : "Hành động thất bại";

            // Đặt thông báo phản hồi là một thuộc tính để hiển thị ở phía máy khách
            request.setAttribute("message", message);

            // Chuyển tiếp yêu cầu tới một trang JSP để hiển thị thông báo hoặc thực hiện các hành động tiếp theo
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/user_management.jsp");
            dispatcher.forward(request, response);
        } else {
            // Nếu userId hoặc action là null, xử lý lỗi hoặc chuyển hướng tới trang lỗi
            response.sendRedirect("error.jsp");
        }
    }
}
