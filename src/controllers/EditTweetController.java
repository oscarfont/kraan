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

import models.BeanTweet;
import utils.DAO;

/**
 * Servlet implementation class MainController
 */
@WebServlet("/EditTweetController")
public class EditTweetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditTweetController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	private BeanTweet fillBeanTweet(ResultSet tweet_rows) {

		BeanTweet tweet = new BeanTweet();
		try {
			// iterate through ResultSets rows
			tweet_rows.beforeFirst();
			while (tweet_rows.next()) {
				// Fill current BeanTweet object
				tweet.setId(tweet_rows.getInt("Tweet_Id"));
				tweet.setAuthor(tweet_rows.getString("Author"));
				tweet.setContent(tweet_rows.getString("Content"));
				tweet.setDate(tweet_rows.getDate("Date"));
				tweet.setLikes(tweet_rows.getInt("Likes"));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return tweet;
	}
	
	private void fillInterests(BeanTweet tweet, ResultSet interest_rows){
		try {
			interest_rows.beforeFirst();
			ArrayList<String> inter = new ArrayList<String>();
			while (interest_rows.next()) {
				// Fill current BeanTweet object
				inter.add(interest_rows.getString("Interest"));
			}
			String[] intrests = {};
			intrests = inter.toArray(intrests);
			tweet.setInterests(intrests);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// Parse interests
    public String[] parseInterests(String interestsString){
    	interestsString = interestsString.replace("[", "");
    	interestsString = interestsString.replace("]", "");
    	String[] output = interestsString.split(",");
    	System.out.println(output.length);
    	return output;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// to print tweet to edit
		String tweet_id = (String) request.getParameter("tweet_id");
		String actionString = (String) request.getParameter("action");
		BeanTweet tweet = new BeanTweet();
		
		// to update tweet in tables and interests
		String new_content = (String) request.getParameter("new_content");
		String interestString = (String) request.getParameter("new_interests");
		String[] interests = {};
		if(interestString != null){
			interests = parseInterests(interestString);	
		}
		long time = System.currentTimeMillis();
		java.sql.Date new_date = new java.sql.Date(time);
		
		// decide which action to do
		int action = Integer.parseInt(actionString);
		
		if(action == 0){
			// update DB with new tweet
			try {

				DAO dao = new DAO();
				
				// Update Tweet Row
				String editTweetQuery = "UPDATE Tweet SET content='"+ new_content + "', date='" + new_date.toString() + "' WHERE Tweet_Id="+ tweet_id + ";";
				dao.UpdateSQL(editTweetQuery);

				// Update Interests
				if(interests.length != 0){
					
					String checkInterestQuery = "SELECT * FROM tweet_has_interests WHERE Tweet_id="+ tweet_id + " AND Interest='";
					System.out.println(checkInterestQuery);
					String deleteInterests = "DELETE FROM tweet_has_interests WHERE Tweet_id=" + tweet_id + ";";
					dao.UpdateSQL(deleteInterests);
					
					for(String interest : interests){
						if(interest == "") continue;
						checkInterestQuery += interest + "';";
						ResultSet rsl = dao.executeSQL(checkInterestQuery);
						if(!rsl.first()){
							String insertInterest = "INSERT INTO tweet_has_interests(Tweet_Id,Interest) VALUES("+ tweet_id + ", '" + interest + "');";
							dao.UpdateSQL(insertInterest);
						}
						checkInterestQuery = "SELECT * FROM tweet_has_interests WHERE Tweet_id="+ tweet_id + " AND Interest='";
					}
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			//Display tweet edition
			try {

				DAO dao = new DAO();

				String getTweetQuery = "SELECT * FROM Tweet WHERE Tweet_Id='" + tweet_id + "';";
				String getInterests = "SELECT * FROM tweet_has_interests WHERE Tweet_Id ='" + tweet_id + "';"; 
				ResultSet rs = dao.executeSQL(getTweetQuery);

				if (rs.first()) {
					tweet = fillBeanTweet(rs);
				}
				
				ResultSet rs2 = dao.executeSQL(getInterests);
				
				if (rs2.first()){
					fillInterests(tweet,rs2);
				}

				request.setAttribute("tweet", tweet);
				RequestDispatcher dispatcher = request.getRequestDispatcher("ViewEditTweet.jsp");
				dispatcher.forward(request, response);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
