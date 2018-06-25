package utils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.BeanLogin;
import models.BeanUser;

/**
 * Servlet implementation class DAO
 */
@WebServlet("/DAO")
public class DAO extends HttpServlet {
	private Connection connection;
	private Statement statement;
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DAO() throws Exception {
    	
		String user = "mysql";
		String password = "prac";
		String database = "kraan";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		connection=DriverManager.getConnection("jdbc:mysql://localhost/"+database+"?user="+user+"&password="+password+"&useSSL=false");
		
		statement = connection.createStatement();
        //super();
        
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public ResultSet executeSQL(String query) throws SQLException{
		return statement.executeQuery(query);
	}
	
	public int UpdateSQL(String query) throws SQLException{
		return statement.executeUpdate(query);
	}
	
	public void addUser(BeanUser user, HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
		
		//Verify that the username does not exist in our DB
		String User_query = "SELECT U.Username FROM Users U WHERE U.Username = '" + user.getUser() + "';";
		ResultSet checkUser = executeSQL(User_query);
		boolean Userexists = checkUser.first();
		
		//Verify that the email does not exist in our DB
		String Mail_query = "SELECT U.Username FROM Users U WHERE U.Email = '" + user.getMail() + "';";
		ResultSet checkMail = executeSQL(Mail_query);
		boolean Mailexists = checkMail.first();
		
		// Verification
		if (!Mailexists && !Userexists) {
			// No data in Users
			
			// Salt the Password
			String oldPassword = user.getPassword();
			Salter salter = new Salter();
			String salterPassword = salter.md5(oldPassword);
			user.setPassword(salterPassword);
			
			// Create Query to insert User
			String newUser = "INSERT INTO Users(Name, Surname, Gender, Username, Email, Password, IsAdmin) VALUES(";
			newUser = newUser + "'" + user.getName() + "', '" +  user.getSurname() + "', '" + user.getGender() + "', '" + user.getUser() + "', '" + user.getMail() + "', '" + user.getPassword() + "', 0);";
			
			// Add User to table
			System.out.println();
			UpdateSQL(newUser);
			
			String[] interests = user.getInterests();
			// If the user introduced interests
			System.out.println(interests);
			if(interests != null){
				// Add User and his Interests to the Interests Table
				for(String i : interests){
					String newInterest = "INSERT INTO Interests(Username, Interest) VALUES(";
					newInterest = newInterest + "'" + user.getUser() + "', '" +  i + "');";
					UpdateSQL(newInterest);
				}
			}
			
			String description = user.getDescription();
			// If the user introduced a Description
			if(!description.isEmpty()){
				// Add User and his Description to the Descriptions Table
				String descritpion_query = "INSERT INTO Descriptions(Username, Description) VALUES(";
				descritpion_query = descritpion_query + "'" + user.getUser() + "', '" +  description + "');";
				UpdateSQL(descritpion_query);
			}
			
			//If user is successfully registered, send user to Welcome_page.jsp!
			//RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
			//dispatcher.forward(request, response);
			
		}else{
			int[] newError = {0,0,0,0,0,0,0,0};
			
			//If there were errors in the registration process do not let the user proceed
			//RequestDispatcher dispatcher = request.getRequestDispatcher("/ViewRegisterForm.jsp");
			
			if(Userexists)
				newError[3] = 1;
			
			if(Mailexists)
				newError[4] = 1;
			
			user.setError(newError);
			
			//Update User Attributes
			//request.setAttribute("user",user);
			//dispatcher.include(request, response);
		}

	}
	
	public void disconnectBD() throws SQLException{
		statement.close();
		connection.close();
	}
	
	public void login(BeanLogin login) throws SQLException {
		
		// Salt the Password
		String oldPassword = login.getPassword();
		Salter salter = new Salter();
		String salterPassword = salter.md5(oldPassword);
		login.setPassword(salterPassword);
		
		String loginQuery = "SELECT Username FROM Users WHERE Username = '" + login.getUser() + "' AND Password = '" + login.getPassword() + "';";
		ResultSet checkLogin = executeSQL(loginQuery);
		System.out.println(loginQuery);
		boolean loginCorrect = checkLogin.first();
		//System.out.println(checkLogin.getString(1));
		if(!loginCorrect) {
			int newError = 0;
			newError = 1;
			login.setError(newError);
		}
	}
	
	public void profile(BeanUser user, String username) throws SQLException{

		String nameQuery = "SELECT Name FROM Users WHERE Username = '" + username + "';";
		ResultSet name = executeSQL(nameQuery);
		System.out.println(nameQuery);
		name.first();
		user.setName(name.getString(1));
		
		String surnameQuery = "SELECT Surname FROM Users WHERE Username = '" + username + "';";
		ResultSet surname = executeSQL(surnameQuery);
		surname.first();
		user.setSurname(surname.getString(1));
		
		String genderQuery = "SELECT Gender FROM Users WHERE Username = '" + username + "';";
		ResultSet gender = executeSQL(genderQuery);
		gender.first();
		user.setGender(gender.getString(1));
		
		user.setUser(username);
		
		String emailQuery = "SELECT Email FROM Users WHERE Username = '" + username + "';";
		ResultSet Email = executeSQL(emailQuery);
		Email.first();
		user.setMail(Email.getString(1));	
		
		String descriptionQuery ="SELECT Description FROM Descriptions WHERE Username ='" + username + "';";
		ResultSet description = executeSQL(descriptionQuery);
		if(description.first()) {
			user.setDescription(description.getString(1));
		}
		String jobQuery = "SELECT Job FROM Users WHERE Username = '" + username + "';";
		ResultSet job = executeSQL(jobQuery);
		//Aqui tractar el tema de que no hi hagi resultset
		if(job.first()){
			if(job.getString(1) != null){
				String result = job.getString(1);
				user.setJob(result);
				System.out.println(job.getString(1));
			}
			
		}else{
			user.setJob("");
		}
		String locationQuery = "SELECT Location FROM Users WHERE Username = '" + username + "';";
		System.out.println(locationQuery);
		ResultSet location = executeSQL(locationQuery);
		//Aqui tractar el tema de que no hi hagi resultset
		//Mirar nomes la location, if(location.getString(1) == NULL)
		if(location.first()){
			
			if(location.getString(1) != null){
				String result = location.getString(1);
				user.setLocation(result);
				System.out.println(location.getString(1));
			}
			
		}else{
			user.setLocation("");
		}
		String birthQuery = "SELECT Birthdate FROM Users WHERE Username = '" + username + "';";
		System.out.println(birthQuery);
		ResultSet birth = executeSQL(birthQuery);

		if(birth.first()){
			
			if(birth.getString(1) != null){
				String result = birth.getString(1);
				user.setBirthdate(result);
				System.out.println(birth.getString(1));
			}
			
		}else{
			user.setBirthdate("");
		};
		
		String interestsQuery = "SELECT Interest FROM Interests WHERE Username = '" + username + "';";
		System.out.println(interestsQuery);
		ResultSet interests = executeSQL(interestsQuery);
		
		if(interests.first()){
			int i = 0;
				while(interests.next()) {
					i++;
				}
			String [] interestList = new String[i];
			interests.isFirst();
			i = 0;
				while(interests.next()) {
					interestList[i] = interests.getString(1);
					//System.out.println(interests.getString(1));
					i++;
				}
				
				user.setInterests(interestList);		
		}else{
			user.setBirthdate("");
		};
		
	}
	public void modifyUser(BeanUser user) throws SQLException {
		
		String username = user.getUser();		
		
		//String updateQuery = "UPDATE Users SET Name='" + user.getName() + "', Surname='" + user.getSurname() + "', Gender='" + user.getGender() + 
				//"', Job='" + user.getJob() + "', Location='" + user.getLocation() + "' WHERE Username ='" + username + "';";
		//System.out.println(updateQuery);
		//int result = UpdateSQL(updateQuery);

		//Update Name
		String name = user.getName();
		if(!name.equals("")){
			String updatename = "UPDATE Users SET Name='" + name + "' WHERE Username ='" + username + "';";
			int result = UpdateSQL(updatename);
		}
		
		//Update Surname
		String surname = user.getSurname();
		if(!surname.equals("")){
			String updatesurname = "UPDATE Users SET Surname='" + surname + "' WHERE Username ='" + username + "';";
			int result = UpdateSQL(updatesurname);
		}		
		
		//Update Gender
		String gender = user.getGender();
		if(!gender.equals("")){
			String updategender = "UPDATE Users SET Gender='" + gender + "' WHERE Username ='" + username + "';";
			int result = UpdateSQL(updategender);
		}
		
		//Update Gender
		String location = user.getLocation();
		if(!location.equals("")){
			String updatelocation = "UPDATE Users SET Location='" + location + "' WHERE Username ='" + username + "';";
			int result = UpdateSQL(updatelocation);
		}
		
		//Update Job
		String job = user.getJob();
		if(!job.equals("")){
			String updatejob = "UPDATE Users SET Job='" + job + "' WHERE Username ='" + username + "';";
			int result = UpdateSQL(updatejob);
		}
		
		//Update Birthdate
		/*String birthdate = user.getBirthdate();
		if(!birthdate.equals("")){
			String updatebirthdate = "UPDATE Users SET Birthdate='" + birthdate + "' WHERE Username ='" + username + "';";
			int result = UpdateSQL(updatebirthdate);
		}*/
	}


}
