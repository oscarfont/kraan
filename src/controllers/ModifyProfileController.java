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
 * Servlet implementation class ModifyProfileController
 */
@WebServlet("/ModifyProfileController")
public class ModifyProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Modify profile Controller");
		
		   try {
			   HttpSession session = request.getSession();
			   //BeanLogin userLogin = (BeanLogin) session.getAttribute("user");
			   String username = (String) request.getParameter("username");
			   //String username = userLogin.getUser();
			   System.out.println(username);
			   //String toLoad = (String) request.getParameter("toLoad");
			   //System.out.println(username);
			   BeanUser user = new BeanUser();
			   DAO dao = new DAO();
			   BeanUtils.populate(user, request.getParameterMap());
			   
			
			   if (user.isComplete()) {
				  
				   
				   //System.out.println(user.getError()[3]);
				   //System.out.println(user.getError()[4]);
				   if(user.getError()[3] == 1 || user.getError()[4] == 1){
					   RequestDispatcher dispatcher = request.getRequestDispatcher("ViewModifyForm.jsp");
					   dispatcher.forward(request, response);
				   }else{
					   dao.modifyUser(user);
					   RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
					   dispatcher.forward(request, response);
				   }

			   
			   } 
			   else {
				   dao.profile(user, username);
				   //String formLoaded = "Yes";
				   //request.setAttribute("toLoad",formLoaded);
				   request.setAttribute("user", user);
				   RequestDispatcher dispatcher = request.getRequestDispatcher("ViewModifyForm.jsp");
				   dispatcher.forward(request, response);
			   
			   }
		   
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
