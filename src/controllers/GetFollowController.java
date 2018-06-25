package controllers;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.BeanLogin;
import models.BeanUser;
import utils.DAO;

@WebServlet("/GetFollowController")
public class GetFollowController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetFollowController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.println("Get Follow Controller");
		
		String option = (String) request.getParameter("option");
		String username = (String) request.getParameter("currentUser");
		if(username == null || option == null) return;
		
		//if the user is the owner
		if(username.equals("Yes")){
			HttpSession session = request.getSession();
			BeanLogin user = (BeanLogin) session.getAttribute("user");
			username = user.getUser();
		}

		try {
			DAO dao = new DAO();

			if(option.equals("following"))
			{
				String query1 = "SELECT COUNT(Following) AS num FROM users_follows_users WHERE User = '" + username + "';";
				System.out.println("---------------------------------------");
				System.out.println(query1);
				ResultSet rs1 = dao.executeSQL(query1);
				if(rs1.first())
				{
					int numUsers = rs1.getInt("num");
					System.out.println("num total: " + numUsers);
				
					//get the result
					String query2 = "SELECT Following FROM users_follows_users WHERE User = '" + username + "';";
					System.out.println(query2);
					ResultSet rs2 = dao.executeSQL(query2);
					if(rs2.first())
					{
						//fill the array
						BeanUser[] followings = new BeanUser[numUsers];
						int current = 0;
						rs2.beforeFirst();
						
				    	while (rs2.next()) {
				    		BeanUser user = new BeanUser();
				    		user.setUser(rs2.getString("Following"));
				    		System.out.println(rs2.getString("Following"));
				    		followings[current] = user;
				    		current++;
				    	}
					
						//pass users to request
						request.setAttribute("followings", followings);
						
						System.out.println("---------------------------------------");
					
						RequestDispatcher dispatcher = request.getRequestDispatcher("ViewFollowings.jsp");
						dispatcher.forward(request, response);
					}
				}
			}
			
			else if(option.equals("followers"))
			{
				String query1 = "SELECT COUNT(User) AS num FROM users_follows_users WHERE Following = '" + username + "';";
				System.out.println("---------------------------------------");
				System.out.println(query1);
				ResultSet rs1 = dao.executeSQL(query1);
				if(rs1.first())
				{
					int numUsers = rs1.getInt("num");
					System.out.println("num total: " + numUsers);
				
					//get the result
					String query2 = "SELECT User FROM users_follows_users WHERE Following = '" + username + "';";
					System.out.println(query2);
					ResultSet rs2 = dao.executeSQL(query2);
					if(rs2.first())
					{
						//fill the array
						BeanUser[] followers = new BeanUser[numUsers];
						int current = 0;
						rs2.beforeFirst();
						
				    	while (rs2.next()) {
				    		BeanUser user = new BeanUser();
				    		user.setUser(rs2.getString("User"));
				    		System.out.println(rs2.getString("User"));
				    		followers[current] = user;
				    		current++;
				    	}
					
						//pass users to request
						request.setAttribute("followers", followers);
						
						System.out.println("---------------------------------------");
					
						RequestDispatcher dispatcher = request.getRequestDispatcher("ViewFollowers.jsp");
						dispatcher.forward(request, response);
					}
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