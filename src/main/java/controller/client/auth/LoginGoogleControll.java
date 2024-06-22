package controller.client.auth;

import controller.client.AccessGoogle.GooglePojo;
import controller.client.AccessGoogle.GoogleUtils;
import dao.client.AccountDAO;
import dao.client.Logging;

import model.Account;
import model.Role;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "login-google", value = "/login-google")
public class LoginGoogleControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            RequestDispatcher dis = request.getRequestDispatcher("/WEB-INF/login.jsp");
            dis.forward(request, response);
        } else {
            String accessToken = GoogleUtils.getToken(code);
            GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);

            AccountDAO accountDAO = new AccountDAO();
            Account account = accountDAO.findByEmail(googlePojo.getEmail());

            if (account == null) {
                // Tạo tài khoản mới
                account = new Account();
                account.setName(googlePojo.getName());
                account.setEmail(googlePojo.getEmail());
                account.setPassword(""); // Mật khẩu để trống hoặc đặt một giá trị mặc định
                Role role = new Role();
                role.setId(0);
                account.setRole(role);
                System.out.println(account);
                accountDAO.insertAccount(account);
                account=AccountDAO.getAccountByEmail(googlePojo.getEmail());
                System.out.println(account);
                // Tạo session cho người dùng
                HttpSession session = request.getSession();
                session.setAttribute("account", account);
                session.setMaxInactiveInterval(60 * 60);
            }

//            // Ghi log đăng nhập
//            Logging.login(account);

           // Chuyển hướng tới trang chính
            RequestDispatcher dis = request.getRequestDispatcher("/WEB-INF/index.jsp");
            dis.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}