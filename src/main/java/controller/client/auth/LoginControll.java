package controller.client.auth;

import dao.client.AccountDAO;
import model.Account;
import model.Encode;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

@WebServlet(name = "LoginControll", value = "/LoginControll")
public class LoginControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie arr[] = request.getCookies();
        for (Cookie cookie : arr) {
            if (cookie.getName().equals("userN")) {
                request.setAttribute("username", URLDecoder.decode(cookie.getValue(), "UTF-8"));
            }
            if (cookie.getName().equals("passW")) {
                request.setAttribute("password", URLDecoder.decode(cookie.getValue(), "UTF-8"));
            }
        }
        request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String userName = request.getParameter("username");
        String passWord = request.getParameter("password");
        System.out.println(userName);
        System.out.println(passWord);

        boolean checkSpaceName = userName.trim().isEmpty();
        boolean checkSpacePass = passWord.trim().isEmpty();

        if (userName == null || checkSpaceName) {
            String errorN = "Enter username";
            request.setAttribute("errorN", errorN);
            System.out.println(errorN);
        }

        if (passWord == null || checkSpacePass) {
            String errorP = "Enter password";
            request.setAttribute("errorP", errorP);
            request.setAttribute("username", userName);
            System.out.println(errorP);
        }

        if (userName != null && passWord != null && !checkSpaceName && !checkSpacePass) {
            String enpass = Encode.toSHA1(passWord);
            Account account = AccountDAO.checkLogin(userName, enpass);

            if (account != null) {
                // not Admin
                if (account.getIsAdmin() == 0) {
                    // Session
                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
                    session.setMaxInactiveInterval(60 * 60);

                    // Cookie
                    Cookie c1 = new Cookie("userN", URLEncoder.encode(userName, "UTF-8"));
                    Cookie c2 = new Cookie("passW", URLEncoder.encode(passWord, "UTF-8"));
                    c1.setMaxAge(60 * 60 * 24 * 30);
                    c2.setMaxAge(60 * 60 * 24 * 30);
                    response.addCookie(c1);
                    response.addCookie(c2);

                    response.sendRedirect(request.getContextPath() + "/IndexControll");
                    return;
                }
                // is admin
                if (account.getIsAdmin() == 1) {
                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
                    session.setMaxInactiveInterval(60 * 60);

                    // Cookie
                    Cookie c1 = new Cookie("userN", URLEncoder.encode(userName, "UTF-8"));
                    Cookie c2 = new Cookie("passW", URLEncoder.encode(passWord, "UTF-8"));
                    c1.setMaxAge(60 * 60 * 24 * 30);
                    c2.setMaxAge(60 * 60 * 24 * 30);
                    response.addCookie(c1);
                    response.addCookie(c2);

                    response.sendRedirect(request.getContextPath() + "/IndexControll");
                    return;

                }
            } else {
                String error = "Username or password incorrect!";
                request.setAttribute("error", error);
                request.setAttribute("username", userName);
            }
        }
        request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);

    }
}