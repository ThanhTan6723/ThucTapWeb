package controller.client.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VerifyControll")
public class VerifyControll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String num1 = request.getParameter("num1");
		String num2 = request.getParameter("num2");
		String num3 = request.getParameter("num3");
		String num4 = request.getParameter("num4");

		String sum = (num1 + num2 + num3 + num4);
		System.out.println(sum);

		String code = String.valueOf(ForgotPasswordControll.getCode());
		System.out.println(code);

		if (sum.equals(code)) {
			System.out.println("verify successful");
			response.sendRedirect(request.getContextPath() + "/ResetPassword");
			return;
		} else {
			System.out.println("verify fail");
			String error="OTP code incorrect";
			request.setAttribute("error", error);
		}

		getServletContext().getRequestDispatcher("/WEB-INF/client/verify.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
