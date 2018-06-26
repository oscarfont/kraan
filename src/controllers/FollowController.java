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
		BeanLogin user = null;
		if(session.getAttribute("user") != null){
			user = (BeanLogin) session.getAttribute("user");
		}
		String tofollow = (String) request.getParameter("following");
		String checking = (String) request.getParameter("checking");
		
		try {
			
			DAO dao = new DAO();
			
			if(user == null) return;
			
			//check the following state at loading the page
			if(checking != null){
				String checkFollow = "SELECT * FROM users_follows_users WHERE User='" + user.getUser() + "' AND Following='" + tofollow + "';" ;
				System.out.println(checkFollow);
				ResultSet rs = dao.executeSQL(checkFollow);
				boolean FollowExists = rs.first();
				
				if(FollowExists){
					RequestDispatcher dispatcher = request.getRequestDispatcher("ViewUnfollow.jsp");
					dispatcher.forward(request, response);
				} else {
					RequestDispatcher dispatcher = request.getRequestDispatcher("ViewFollow.jsp");
					dispatcher.forward(request, response);
				}
			
			//do the follow or unfollow
			} else {
				String checkFollow = "SELECT * FROM users_follows_users WHERE User='" + user.getUser() + "' AND Following='" + tofollow + "';" ;
				System.out.println(checkFollow);
				ResultSet rs = dao.executeSQL(checkFollow);
				boolean FollowExists = rs.first();
				
				if(FollowExists){
					String Followquery = "DELETE FROM users_follows_users WHERE User='" + user.getUser() + "' AND Following='" + tofollow + "';";
					System.out.println(Followquery);
					dao.UpdateSQL(Followquery);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("ViewFollow.jsp");
					dispatcher.forward(request, response);
				}else{
					String Followquery = "INSERT INTO users_follows_users(User,Following) VALUES('" + user.getUser() + "', '" + tofollow + "');";
					System.out.println(Followquery);
					dao.UpdateSQL(Followquery);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("ViewUnfollow.jsp");
					dispatcher.forward(request, response);
				}
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}