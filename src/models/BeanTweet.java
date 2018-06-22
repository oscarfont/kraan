package models;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import utils.DAO;

public class BeanTweet {
	
	private int id;
	private String author;
	private String content;
	private Date date;
	private int likes;
	// 0: publish, 1: delete -> the Tweet 
	private int action;
	private String[] interests;
	
	// Getters
	public int getId() {return id;}
	public String getAuthor() {return author;}
	public String getContent() {return content;}
	public Date getDate() {return date;}
	public int getLikes() {return likes;}
	public int getAction() {return action;}
	public String[] getInterests() {return interests;}
	
	// Setters
	public void setId(int id) {this.id = id;}
	public void setAuthor(String author) {this.author = author;}
	public void setContent(String content) {this.content = content;}
	public void setDate(Date date) {this.date = date;}
	public void setLikes(int likes) {this.likes = likes;}
	public void setAction(int action) {this.action = action;}
	public void setInterests(String[] interests) {this.interests = interests;}
	
	
	// Publish Tweets
	public void publish(DAO dao, String[] Interests){
		
		// Insert Tweet query
		String insertTweet = "INSERT INTO tweet(Author, Content, Date, Likes) VALUES('"+ getAuthor() + "', '" + getContent() + "', '" + getDate() + "', 0);";
	
		// Query to get Id of last inserted tweet
		String IdQuery = "Select Tweet_Id from tweet WHERE Author ='" + getAuthor() + "';";
		
		/* DEBUG
		System.out.println(IdQuery);*/
		
		try {
			// Insert Interests of tweet
			/* DEBUG
			System.out.println(insertTweet);*/
			dao.UpdateSQL(insertTweet);
			
			// get id of last inserted tweet
			ResultSet IDs = dao.executeSQL(IdQuery);
			IDs.last();
			int Id = IDs.getInt("Tweet_id");
			
			// If the tweet has Interests
			if(Interests[0] != "" && Interests != null){
				for(String interest : Interests){
					String insertInterests = "INSERT INTO tweet_has_interests(Tweet_Id, Interest) VALUES("+ Id + ", '" + interest + "');";
					/* DEBUG
					 * System.out.println(insertInterests);*/
					dao.UpdateSQL(insertInterests);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public void delete(DAO dao){
		
		String deleteTweet = "DELETE FROM tweet WHERE Tweet_Id='" + getId() + "';";
		
		try {
			dao.UpdateSQL(deleteTweet);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// Delete from table Interests
	}
	
	public boolean isPublish(){
		
		if(action == 0) return true;
		
		return false;
	}

}
