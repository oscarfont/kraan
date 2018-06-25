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
import javax.servlet.http.HttpSession;

import models.BeanLogin;
import models.BeanTweet;
import utils.DAO;

@WebServlet("/FilterController")
public class FilterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FilterController() { 
    	super(); 
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
				tweets[current] = tweet;
				current++;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try {
			
			DAO dao = new DAO();
			
			HttpSession session = request.getSession();
			BeanLogin user = (BeanLogin) session.getAttribute("user");
			
			String actionString = (String) request.getParameter("accion");
			int action = Integer.parseInt(actionString);
			int number_of_tweets = 0;
			
			String username = user.getUser();
			
			ResultSet tweet_rows = null;
			
			if(action == 0){
			// Filter tweets by Follows
				
				String followQuery = "SELECT * FROM Tweet WHERE Author IN (";
				String followSubQuery = "SELECT Following FROM users_follows_users WHERE User='"+ username + "'";
				
				followQuery += followSubQuery + ");";
				
				String countQuery = "SELECT COUNT(*) AS num FROM Tweet WHERE Author IN (";
				countQuery += followSubQuery + ");";
				
				ResultSet count = dao.executeSQL(countQuery);
				
				System.out.println(followQuery);
				System.out.println(countQuery);
				
				if(count.first()){
					number_of_tweets = count.getInt("num");
					tweet_rows = dao.executeSQL(followQuery);
				}
				
				
			}else{
			// Filter by Interests
				
				String UserinteretstQuery = "SELECT Interest FROM interests WHERE Username='"+ username + "'";
				String tweets_ids = "SELECT Tweet_Id FROM tweet_has_interests WHERE Interest IN (";
				
				tweets_ids += UserinteretstQuery + ")";
				
				String countQuery = "SELECT COUNT(*) AS num FROM Tweet WHERE Tweet_Id IN (";
				countQuery += tweets_ids + ");";
				
				ResultSet count = dao.executeSQL(countQuery);
				System.out.println(countQuery);
				
				if(count.first()){
					number_of_tweets = count.getInt("num");
					
					String tweets_interests = "SELECT * FROM Tweet WHERE Tweet_Id IN (";
					tweets_interests += tweets_ids + ");";
					
					System.out.println(tweets_interests);
					
					tweet_rows = dao.executeSQL(tweets_interests);
				}
				
			}
			
			// Fill Beantweet[]
			BeanTweet[] tweets = new BeanTweet[number_of_tweets];
			fillBeanTweetsArray(tweets, tweet_rows);

			// If tweets have interests get them
			String interestsQuery = "SELECT Interest FROM tweet_has_interests WHERE Tweet_Id =";

			for (int i = 0; i < tweets.length; i++) {

				// complete query
				interestsQuery += tweets[i].getId() + ";";
				ResultSet interest_rows = dao.executeSQL(interestsQuery);

				// Restart string query
				interestsQuery = "SELECT Interest FROM tweet_has_interests WHERE Tweet_Id =";

				// if tweet has interests
				ArrayList<String> interest_array = new ArrayList<String>();
				interest_rows.beforeFirst();
				while (interest_rows.next()) {
					String interest = interest_rows.getString("Interest");
					interest_array.add(interest);
				}

				if (!interest_array.isEmpty()) {
					String[] interests = new String[interest_array.size()];
					interests = interest_array.toArray(interests);
					// update tweet
					tweets[i].setInterests(interests);
				}
			}

			// pass tweets to request
			request.setAttribute("tweets", tweets);

			RequestDispatcher dispatcher = request.getRequestDispatcher("ViewTweets.jsp");
			dispatcher.forward(request, response);
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}