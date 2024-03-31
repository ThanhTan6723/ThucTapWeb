package controller.client.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.AccountDAO;
import model.Account;
import model.Encode;

@WebServlet("/ResetPassword")
public class ResetPasswordControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/client/reset-password.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String pass = request.getParameter("passw");
		String repass = request.getParameter("repassw");

		HttpSession session = request.getSession();

		if (pass == null || pass.trim().isEmpty()) {
			request.setAttribute("errorP", "Enter new password");
		}
		if (repass == null || repass.trim().isEmpty()) {
			request.setAttribute("errorRP", "Enter confirm password");
		}

		if (pass != null && repass != null && pass.trim().isEmpty() == false && repass.trim().isEmpty() == false) {
			if (!pass.equals(repass)) {
				request.setAttribute("errorRP", "Password incorrect");
			} else {
				String enPass = Encode.toSHA1(pass);
				Account acc = new Account();
				acc.setEmail((String) session.getAttribute("email"));
				acc.setPassword(enPass);
				AccountDAO.update(acc);
				System.out.println("reset success");
				response.sendRedirect(request.getContextPath() + "/LoginControll");
				return;
			}
		}
		request.getRequestDispatcher("/WEB-INF/client/reset-password.jsp").forward(request, response);
	}

}
