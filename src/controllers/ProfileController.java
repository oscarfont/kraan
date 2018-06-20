package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import models.BeanLogin;
import models.BeanUser;
import utils.DAO;

/**
 * Servlet implementation class ProfileController
 */
@WebServlet("/ProfileController")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Profile Controller");
		BeanUser user = new BeanUser();
		
		try {

			BeanUtils.populate(user, request.getParameterMap());
			HttpSession session = request.getSession();
			BeanLogin userlogin = (BeanLogin) session.getAttribute("user");
			String username = userlogin.getUser();
			DAO dao = new DAO();
			dao.profile(user, username);
			//System.out.println(user.getJob());
			//System.out.println(user.getLocation());
			request.setAttribute("user", user);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("ViewProfile.jsp");
			dispatcher.forward(request, response);
			//response.getWriter().append("Served at: ").append(request.getContextPath());
			
			
			//System.out.println(user.getJob());
			
			
			
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
