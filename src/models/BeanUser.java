package models;

import java.io.Serializable;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

public class BeanUser implements Serializable  {

	private static final long serialVersionUID = 1L;

	private String name = "";
	private String surname = "";
	private String gender = "";
	private String user = "";
	private String mail = "";
	private String password = "";
	private String description = "";
	private String[] interests;
	
	
	/*  Control which parameters have been correctly filled */
	private int[] error = {0,0,0,0,0,0,0,0}; 
	
	/* Getters */
	public String getUser(){ return user; }
	public String getMail() { return mail; }
	public int[] getError() { return error; }
	public String getName() { return name; }
	public String getSurname() { return surname; }
	public String getGender() { return gender; }
	public String getPassword() { return password; }
	public String getDescription() { return description; }
	public String[] getInterests() { return interests; }
	
	
	/* Setters */
	public void setUser(String user){
		System.out.println("Filling user field");
		this.user = user;
		/* We simulate a user with the same unsername exists in our DB */
		//error[0] = 1;
	}
	public void setMail(String mail){ System.out.println("Filling mail field"); this.mail = mail; }	
	public void setName(String name) { System.out.println("Filling name field"); this.name = name; }
	public void setSurname(String surname) { System.out.println("Filling surname field"); this.surname = surname; }
	public void setGender(String gender) {	System.out.println("Filling gender field"); this.gender = gender; }
	public void setPassword(String password) { System.out.println("Filling password field"); this.password = password; }
	public void setDescription(String description) { System.out.println("Filling description field"); this.description = description; }
	public void setInterests(String[] interests) { System.out.println("Filling interests field"); this.interests = interests; }
	public void setError(int[] newError){ this.error = newError; }
	
	
	/* Logic Functions */
	
	/*Check if all the fields are filled correctly */
	public boolean isComplete() {
	    return(hasValue(getUser()) && hasValue(getMail()) && hasValue(getName()) && hasValue(getSurname()) 
	    		&& hasValue(getPassword()) && hasValue(getGender()));
	}
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}
}