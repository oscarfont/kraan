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
import models.BeanTweet;
import utils.DAO;

@WebServlet("/TweetController")
public class TweetController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	 /**
     * @see HttpServlet#HttpServlet()
     */
    public TweetController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Parse interests
    public String[] parseInterests(String interestsString){
    	interestsString = interestsString.replace("[", "");
    	interestsString = interestsString.replace("]", "");
    	String[] output = interestsString.split(",");
    	return output;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String actionString = (String) request.getParameter("content");
		String tweetContent = (String) request.getParameter("tweet");
		String interestsString = (String) request.getParameter("interests");
		System.out.println(interestsString);
		String[] interests = parseInterests(interestsString);
		int action = Integer.parseInt(actionString);
		
		BeanLogin usuario = (BeanLogin) session.getAttribute("user");
		
		try {
			
			DAO dao = new DAO();
			BeanTweet tweet = usuario.getTweet(action,tweetContent,usuario);
			
			if(tweet.isPublish()){
				
				tweet.publish(dao,interests);
				
			}else{
				
				tweet.delete(dao);
				
			}
			
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
