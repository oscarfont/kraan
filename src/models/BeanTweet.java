package models;

public class BeanTweet {
	
	private int id;
	private String author;
	private String content;
	private String date;
	private int likes;
	
	// Getters
	public int getId() {return id;}
	public String getAuthor() {return author;}
	public String getContent() {return content;}
	public String getDate() {return date;}
	public int getLikes() {return likes;}
	
	// Setters
	public void setId(int id) {this.id = id;}
	public void setAuthor(String author) {this.author = author;}
	public void setContent(String content) {this.content = content;}
	public void setDate(String date) {this.date = date;}
	public void setLikes(int likes) {this.likes = likes;}

}
