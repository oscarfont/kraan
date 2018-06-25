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

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminController() { 
    	super(); 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		BeanLogin user = (BeanLogin) session.getAttribute("user");
		if(user == null) return;
		
		System.out.println("AdminController, loading: " + user.getUser() );
		
		DAO dao;
		try {
			dao = new DAO();
			String query = "SELECT U.IsAdmin FROM Users U WHERE U.Username = '" + user.getUser() + "';";

			ResultSet checkQuery = dao.executeSQL(query);
			boolean queryExists = checkQuery.first();
	
			if(queryExists)
			{			
				if(checkQuery.getInt("U.IsAdmin") == 1) {
					session.setAttribute("admin", true);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("ViewAdmin.jsp");
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