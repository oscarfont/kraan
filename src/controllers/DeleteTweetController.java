package controllers;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.BeanTweet;
import utils.DAO;

/**
 * Servlet implementation class MainController
 */
@WebServlet("/DeleteTweetController")
public class DeleteTweetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteTweetController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String tweet_id = (String) request.getParameter("tweet_id");
		
		try {
			
			DAO dao = new DAO();
			String deleteTweet = "DELETE FROM TWEET WHERE Tweet_Id="+ tweet_id + ";";
			String deleteInterests = "DELETE FROM tweet_has_interests WHERE Tweet_Id"+ tweet_id + ";";
			
			dao.UpdateSQL(deleteTweet);
			dao.UpdateSQL(deleteInterests);
			
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