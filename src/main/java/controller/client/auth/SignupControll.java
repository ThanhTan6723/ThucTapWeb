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

@WebServlet("/SignupControll")
public class SignupControll extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/client/signup.jsp").forward(request, response);
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
			request.setAttribute("error2", "Enter your name");
		}
		if (email == null || checkEmail) {
			request.setAttribute("error3", "Enter your email");
		}
		if (phoneNumber == null || checkPhone) {
			request.setAttribute("error4", "Enter your phone number");
		}
		if (password == null || checkPass) {
			request.setAttribute("error5", "Enter password");
		}
		if (rePassword == null || checkRepass) {
			request.setAttribute("error6", "Enter confirm password");
		}
		boolean checkNameExits = AccountDAO.checkUserName(name);
		if (checkNameExits) {
			request.setAttribute("error2", "Name is already exits");
		}
		boolean checkEmailAvailable = AccountDAO.checkEmail(email);
		if (checkEmailAvailable) {
			request.setAttribute("error3", "Email available");
		}

		boolean checkRetype = password.equals(rePassword);
		if (!checkRetype) {
			request.setAttribute("error6", "Password incorrect");
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
		request.getRequestDispatcher("/client/signup.jsp").forward(request, response);
	}

}
