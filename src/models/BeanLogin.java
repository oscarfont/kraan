package models;

import java.lang.reflect.InvocationTargetException;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;

public class BeanLogin {

	private String user = "";
	private String password = "";
	private int error = 0;
	
	public String getUser(){ return user; }
	public String getPassword() { return password; }
	public int getError() { return error; }
	
	public void setUser(String user){ this.user = user; }
	public void setPassword(String password) { this.password = password; }
	public void setError(int newError){ this.error = newError; }
	
	public boolean isComplete() {
	    return(hasValue(getUser()));
	}
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}
	
	public BeanTweet getTweet(int action, String tweetContent, BeanLogin usuario){
		
		BeanTweet tweet = new BeanTweet();
		tweet.setAction(action);
		tweet.setContent(tweetContent);
		//DEBUG
		System.out.println(tweetContent);
		long time = System.currentTimeMillis();
		java.sql.Date date = new java.sql.Date(time);
		tweet.setDate(date);
		tweet.setAuthor(usuario.getUser());
		
		return tweet;
	}
	
}