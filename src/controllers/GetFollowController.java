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
    
    private void fillBeanFollowArray(BeanUser[] users, ResultSet rs, String col) {
    	
		try {

			int current = 0;
			
	    	while (rs.next()) 
	    	{
	    		BeanUser user = new BeanUser();
	    		user.setUser(rs.getString(col));
	    		users[current]= user;
	    		current++;
	    	}
	    	
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.println("Get Follow Controller");
		
		HttpSession session = request.getSession();
		BeanLogin user = (BeanLogin) session.getAttribute("user");
		String option = (String) request.getParameter("option");
		if(user == null) return;

		try {
			DAO dao = new DAO();

			//choose between following and followers users
			String chooseOption = null;
			if(option.equals("following")){
				chooseOption = "Following";
				//request.setAttribute("option", "following");
			}
			else if(option.equals("followers")){
				chooseOption = "User";
				//request.setAttribute("option", "followers");
			}
			
			//get the number of occurrences
			String query1 = "SELECT COUNT(" + chooseOption + ") AS num FROM users_follows_users WHERE User = '" + user.getUser() + "';";
			System.out.println(query1);
			ResultSet rs1 = dao.executeSQL(query1);
			if(rs1.first())
			{
				int numUsers = rs1.getInt("num");
			
				//get the result
				String query2 = "SELECT " + chooseOption + " FROM users_follows_users WHERE User = '" + user.getUser() + "';";
				System.out.println(query2);
				ResultSet rs2 = dao.executeSQL(query2);
				if(rs2.first())
				{
					//fill the array
					BeanUser[] users = new BeanUser[numUsers];
					fillBeanFollowArray(users, rs2, chooseOption);
				
					//pass users to request
					request.setAttribute("users", users);
				
					RequestDispatcher dispatcher = request.getRequestDispatcher("ViewFollowers.jsp");
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