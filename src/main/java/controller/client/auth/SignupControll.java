package controller.client.auth;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.AccountDAO;
import model.Account;
import model.Encode;

@WebServlet(name = "SignupControll", value = "/SignupControll")
public class SignupControll extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/client/signup.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String password = request.getParameter("passw");
        String rePassword = request.getParameter("repassw");

        boolean checkName = name.trim().isEmpty();
        boolean checkEmail = email.trim().isEmpty();
        boolean checkPhone = phoneNumber.trim().isEmpty();
        boolean checkPass = password.trim().isEmpty();
        boolean checkRepass = rePassword.trim().isEmpty();

        if (name == null || checkName) {
            request.setAttribute("error2", "Vui lòng nhập tên");
        }
        if (email == null || checkEmail) {
            request.setAttribute("error3", "Vui lòng nhập email");
        }
        if (phoneNumber == null || checkPhone) {
            request.setAttribute("error4", "Vui lòng nhập sđt");
        }
        if (password == null || checkPass) {
            request.setAttribute("error5", "Vui lòng nhập mật khẩu");
        }
        if (rePassword == null || checkRepass) {
            request.setAttribute("error6", "Vui lòng nhập xác nhận mật khẩu");
        }
        boolean checkNameExits = AccountDAO.checkUserName(name);
        if (checkNameExits) {
            request.setAttribute("error2", "Tên đã tồn tại");
        }
        boolean checkEmailAvailable = AccountDAO.checkEmail(email);
        if (checkEmailAvailable) {
            request.setAttribute("error3", "Email đã tồn tại");
        }

        boolean checkInputPass = validatePassword(password);
        if (!checkInputPass){
            request.setAttribute("error5", "Mật khẩu phải chứa ít nhất 8 kí tự");
            request.setAttribute("passw", password);
        }

        boolean checkRetype = password.equals(rePassword);
        if (!checkRetype) {
            request.setAttribute("error6", "Mật khẩu không trùng khớp");
            request.setAttribute("passw", password);
        }
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("phone", phoneNumber);

        if (name != null && email != null && phoneNumber != null && password != null && rePassword != null && !checkName
                && !checkEmail && !checkPhone && !checkPass && !checkRepass && !checkNameExits && !checkEmailAvailable
                && checkRetype) {

            String enpass = Encode.toSHA1(password);

            Account account = new Account();
            account.setName(name);
            account.setPassword(enpass);
            account.setEmail(email);
            account.setTelephone(phoneNumber);
            account.setIsAdmin(0);
//			account.setIsDeleted(0);
            System.out.println(account);
            AccountDAO.insertAccount(account);
            response.sendRedirect(request.getContextPath() + "/LoginControll");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/client/signup.jsp").forward(request, response);
    }

    private boolean validatePassword(String password) {
        if (password == null || password.isEmpty()) {
            return false;
        }

        // Kiểm tra độ dài của mật khẩu
        if (password.length() < 8) {
            return false;
        }

        // Kiểm tra xem mật khẩu có chứa ít nhất một chữ cái viết hoa, một chữ cái viết thường, một số và một ký tự đặc biệt hay không
        boolean containsUppercase = false;
        boolean containsLowercase = false;
        boolean containsDigit = false;
        boolean containsSpecialCharacter = false;

        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                containsUppercase = true;
            } else if (Character.isLowerCase(c)) {
                containsLowercase = true;
            } else if (Character.isDigit(c)) {
                containsDigit = true;
            } else {
                containsSpecialCharacter = true;
            }
        }
        return containsUppercase && containsLowercase && containsDigit && containsSpecialCharacter;
    }
}