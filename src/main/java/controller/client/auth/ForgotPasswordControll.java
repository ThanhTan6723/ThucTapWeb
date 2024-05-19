package controller.client.auth;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.client.AccountDAO;
import model.Email;

@WebServlet("/ForgotControll")
public class ForgotPasswordControll extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static Random random = new Random();
	private static int randomCode = generateRandomCode();
	private static String code = String.valueOf(randomCode);

	public static String getCode() {
		return code;
	}

	public static int generateRandomCode() {
		return random.nextInt(9000) + 1000;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String email = request.getParameter("email");
		boolean checkMail = AccountDAO.checkEmail(email);

		if (email == null || email.trim().isEmpty()) {
			request.setAttribute("error", "Enter your email");
		}
		if (email != null && email.trim().isEmpty() == false) {
			if (!checkMail) {
				request.setAttribute("error", "Email does not exist");
			} else {
				System.out.println("Code: " + code);
				Email.sendEmail(email, "Verification", code);
				request.getSession().setAttribute("email", email);
				request.getSession().setAttribute("randomCode", randomCode);
				response.sendRedirect(request.getContextPath() + "/VerifyControll");
				return;
			}
		}

		request.getRequestDispatcher("/WEB-INF/client/forgot-password.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
