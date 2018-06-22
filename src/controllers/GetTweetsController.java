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

import models.BeanTweet;
import utils.DAO;

/**
 * Servlet implementation class MainController
 */
@WebServlet("/GetTweetsController")
public class GetTweetsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetTweetsController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private void fillBeanTweetsArray(BeanTweet[] tweets, ResultSet tweet_rows) {
    	
		try {
	    	// iterate through ResultSets rows
			int current = 0;
	    	while (tweet_rows.next()) {
	    		// Fill current BeanTweet object
	    		BeanTweet tweet = new BeanTweet();
	    		tweet.setId(tweet_rows.getInt("Tweet_Id"));
	    		tweet.setAuthor(tweet_rows.getString("Author"));
	    		tweet.setContent(tweet_rows.getString("Content"));
	    		tweet.setDate(tweet_rows.getDate("Date"));
	    		tweet.setLikes(tweet_rows.getInt("Likes"));
	    		tweets[current]= tweet;
	    		current++;
	    	}
	    	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			DAO dao = new DAO();
			
			// Generate Query to DB
			int number_of_tweets = 3;
			String getTweetsQuery = "SELECT * FROM Tweet LIMIT " + Integer.toString(number_of_tweets) + ";";
			ResultSet tweet_rows = dao.executeSQL(getTweetsQuery);
			
			// Fill Beantweet[]
			BeanTweet[] tweets = new BeanTweet[number_of_tweets];
			fillBeanTweetsArray(tweets,tweet_rows);
			
			//pass tweets to request
			request.setAttribute("tweets", tweets);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("ViewTweets.jsp");
			dispatcher.forward(request, response);	
			
			
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