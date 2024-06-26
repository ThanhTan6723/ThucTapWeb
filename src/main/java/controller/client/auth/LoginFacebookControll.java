package controller.client.auth;

import com.restfb.types.User;
import controller.client.AccessFacebook.RestFB;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "login-facebook", value = "/login-facebook")
public class LoginFacebookControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        System.out.println(code);

        if (code == null || code.isEmpty()) {
            RequestDispatcher dis = request.getRequestDispatcher("/WEB-INF/client/login.jsp");
            dis.forward(request, response);
        } else {
            String accessToken = RestFB.getToken(code);
            Account acc = RestFB.getUserInfo(accessToken);
            System.out.println(acc);
            request.setAttribute("id", acc.getId());
            request.setAttribute("name", acc.getName());
            request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}