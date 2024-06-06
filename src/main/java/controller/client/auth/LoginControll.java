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
import java.util.Date;
import java.util.regex.Pattern;

@WebServlet(name = "LoginControll", value = "/LoginControll")
public class LoginControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userN")) {
                    request.setAttribute("identifier", URLDecoder.decode(cookie.getValue(), "UTF-8"));
                }
                if (cookie.getName().equals("passW")) {
                    request.setAttribute("password", URLDecoder.decode(cookie.getValue(), "UTF-8"));
                }
            }
        }
        request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);
    }
    private String getSourceIp(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (ipAddress == null || ipAddress.isEmpty()) {
            ipAddress = request.getRemoteAddr();
        }
        return ipAddress;
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String identifier = request.getParameter("identifier");
        String passWord = request.getParameter("password");
        String userAgent = request.getHeader("User-Agent");
        String sourceIp = getSourceIp(request);
        System.out.println(userAgent);
        System.out.println(sourceIp);

        boolean checkSpaceIdentifier = identifier.trim().isEmpty();
        boolean checkSpacePass = passWord.trim().isEmpty();
        boolean checkEmailExist = false,
                checkPhoneExist = false;

        if (identifier == null || checkSpaceIdentifier) {
            String errorIdenty = "Vui lòng nhập email hoặc số điện thoại";
            request.setAttribute("errorIdenty", errorIdenty);
            System.out.println(errorIdenty);
        }

        if (passWord == null || checkSpacePass) {
            String errorP = "Vui lòng nhập mật khẩu";
            request.setAttribute("errorP", errorP);
            request.setAttribute("identifier", identifier);
            System.out.println(errorP);
        }

        if (identifier != null && passWord != null && !checkSpaceIdentifier && !checkSpacePass) {
            String enpass = Encode.toSHA1(passWord);
            Account account = null;
            AccountDAO dao = new AccountDAO();
            if (isValidEmail(identifier)) {
                checkEmailExist = AccountDAO.checkFieldExists("email",identifier);
                if (checkEmailExist) {
                    account = dao.getAccountByField("email", identifier, enpass);
                }
            } else if (isValidPhone(identifier)) {
                checkPhoneExist = AccountDAO.checkFieldExists("phonenumber",identifier);
                if (checkPhoneExist) {
                    account = AccountDAO.getAccountByField("phonenumber", identifier, enpass);
                }
            }

            if (account != null) {
                if (account.isLocked()) {
                    String error = "Tài khoản của bạn đã bị khóa do đăng nhập sai quá nhiều lần";
                    request.setAttribute("error", error);
                    request.setAttribute("identifier", identifier);
                    request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);
                    return;
                }

                // Đặt lại số lần đăng nhập thất bại
                AccountDAO.resetFailedAttempts(account.getId());

                // not Admin
                if (account.getRole().getId() == 0) {
                    // Session
                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
                    session.setMaxInactiveInterval(60 * 60);

                    // Cookie
                    Cookie c1 = new Cookie("userN", URLEncoder.encode(identifier, "UTF-8"));
                    Cookie c2 = new Cookie("passW", URLEncoder.encode(passWord, "UTF-8"));
                    c1.setMaxAge(60 * 60 * 24 * 30);
                    c2.setMaxAge(60 * 60 * 24 * 30);
                    response.addCookie(c1);
                    response.addCookie(c2);

                    response.sendRedirect(request.getContextPath() + "/IndexControll");
                    return;
                }
                // is admin
                if (account.getRole().getId() == 1) {
                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
                    session.setMaxInactiveInterval(60 * 60);

                    // Cookie
                    Cookie c1 = new Cookie("userN", URLEncoder.encode(identifier, "UTF-8"));
                    Cookie c2 = new Cookie("passW", URLEncoder.encode(passWord, "UTF-8"));
                    c1.setMaxAge(60 * 60 * 24 * 30);
                    c2.setMaxAge(60 * 60 * 24 * 30);
                    response.addCookie(c1);
                    response.addCookie(c2);

                    response.sendRedirect(request.getContextPath() + "IndexControll");
                    return;
                }
            } else {
                if (checkEmailExist == true || checkPhoneExist == true) {
                    if(checkEmailExist==true){
                        // Nếu đăng nhập thất bại, tăng số lần đăng nhập thất bại
                        int failedAttempts = AccountDAO.getFailedAttempts("email",identifier);
                        if(failedAttempts<5){
                            AccountDAO.incrementFailedAttempts("email", identifier);
                        }
                        if (failedAttempts >= 5) {
                            AccountDAO.lockAccount("email",identifier);
                            String error = "Tài khoản của bạn đã bị khóa do đăng nhập sai quá nhiều lần";
                            request.setAttribute("error", error);
                            request.setAttribute("identifier", identifier);
                        }else {
                            String error = "Email, số điện thoại hoặc mật khẩu không chính xác!";
                            request.setAttribute("error", error);
                            request.setAttribute("identifier", identifier);
                        }
                    }
                    if(checkPhoneExist==true){
                        // Nếu đăng nhập thất bại, tăng số lần đăng nhập thất bại
                        int failedAttempts = AccountDAO.getFailedAttempts("phonenumber",identifier);
                        if(failedAttempts<5){
                            AccountDAO.incrementFailedAttempts("phonenumber", identifier);
                        }
                        if (failedAttempts >= 5) {
                            AccountDAO.lockAccount("phonenumber",identifier);
                            String error = "Tài khoản của bạn đã bị khóa do đăng nhập sai quá nhiều lần";
                            request.setAttribute("error", error);
                            request.setAttribute("identifier", identifier);
                        }else {
                            String error = "Email, số điện thoại hoặc mật khẩu không chính xác!";
                            request.setAttribute("error", error);
                            request.setAttribute("identifier", identifier);
                        }
                    }
                }
            }
        }
        request.getRequestDispatcher("/WEB-INF/client/login.jsp").forward(request, response);
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pat = Pattern.compile(emailRegex);
        return email != null && pat.matcher(email).matches();
    }

    private boolean isValidPhone(String phone) {
        String phoneRegex = "^[0-9]{10}$"; // Adjust this regex based on your phone number format
        Pattern pat = Pattern.compile(phoneRegex);
        return phone != null && pat.matcher(phone).matches();
    }
}
