package controllers;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.BeanLogin;
import utils.DAO;

@WebServlet("/FollowController")
public class FollowController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FollowController() { 
    	super(); 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		BeanLogin user = (BeanLogin) session.getAttribute("user");
		String tofollow = (String) request.getParameter("following");
		System.out.println(tofollow);
		
		try {
			
			DAO dao = new DAO();
			
			String checkFollow = "SELECT * FROM users_follows_users WHERE User='" + user.getUser() + "' AND Following='" + tofollow + "';" ;
			ResultSet rs = dao.executeSQL(checkFollow);
			boolean FollowExists = rs.first();
			
			if(FollowExists){
				
				String Followquery = "DELETE FROM users_follows_users WHERE User='" + user.getUser() + "' AND Following='" + tofollow + "';";
				System.out.println(Followquery);
				dao.UpdateSQL(Followquery);
				
			}else{
				
				String Followquery = "INSERT INTO users_follows_users(User,Following) VALUES('" + user.getUser() + "', '" + tofollow + "');";
				System.out.println(Followquery);
				dao.UpdateSQL(Followquery);
				
			}
			
			request.setAttribute("following", FollowExists);
			RequestDispatcher dispatcher = request.getRequestDispatcher("ViewFollow.jsp");
			dispatcher.forward(request, response);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}