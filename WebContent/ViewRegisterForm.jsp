<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="models.BeanUser" %>
    

<script>
$(document).ready(function(){
	$( "#registerForm" ).submit(function( event ) {
		  /* DEBUG
		  alert( "HOLAAA" );*/
		  event.preventDefault();
		  $('#log-body').load('RegisterController',$("#registerForm").serialize());
	});
});
</script>

<% 
	BeanUser user = null;
	if (request.getAttribute("user")!=null) {
		user = (BeanUser)request.getAttribute("user");
	}
	else {
		user = new BeanUser();
	}
%>

<!-- Register -->
<div id="register-form">
<form id="registerForm" action="" method="POST">

	<p>
		<label> Name </label>
		<input type="text" name="name" class="input-text" id="name" value="<%=user.getName() %>" required maxlength="20">
	</p>
	
	<p>
        <label> Surname </label>
        <input type="text" name="surname" class="input-text" id="surname" value="<%=user.getSurname() %>" required maxlength="30">
    </p>
	
	<p>
      <label> Gender </label><br>
        <input type="radio" name="gender" class="input-radio" value="male"> Male<br>
        <input type="radio" name="gender" class="input-radio" value="female"> Female<br>
        <input type="radio" name="gender" class="input-radio" value="other" checked> Other<br>
	</p>
	
	<p>
        <label> Username </label>
        <input type="text" pattern="[a-zA-Z]{1,20}" title="Only letters with no spaces" name="user" id="user" class="input-text" value="<%=user.getUser() %>" required>
        <%  
          if ( user.getError()[3] == 1 )
            out.println("<small style='color:Tomato'>The username already exists in our DB!</small>");
        %>
    </p>
	
	<p>
        <label> E-mail </label>
        <input type="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" title="Must be a valid mail" name="mail" id="mail" class="input-text" value="<%=user.getMail() %>" placeholder="Enter email..." required>
        <input type="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" title="Must be a valid mail" name="mail" id="mail-conf" class="input-text" placeholder="Repeat email..." required>
        <%
          if (user.getError()[4] == 1)
            out.println("<small style='color:Tomato'>The email already exists in our DB!</small>");
        
          if (request.getParameter("mail-conf") != request.getParameter("mail"))
            out.println("<small style='color:Tomato'>The mails do not match!</small>");
        %>
    </p>
	
	<p>
        <label> Password </label>
        <input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}" title="Must contain at least one number and one uppercase and lowercase letter" name="password" id="password" class="input-text" value="<%=user.getPassword() %>" placeholder="Enter password..." required>
        <input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}" title="Must contain at least one number and one uppercase and lowercase letter"name="password" id="password-conf" class="input-text" placeholder="Repeat password..." required>
        <%
          if (request.getParameter("password-conf") != request.getParameter("password"))
            out.println("<small style='color:Tomato'>The passwords do not match!</small>");
        %>
    </p>
	
	<p>
        <label> User Description </label>
        <textarea type="text" name="description" class="input-text" id="description" value="<%=user.getDescription() %>" maxlength="120"></textarea>
    </p>
	
	<p>
		<label> Select Interests </label><br>
		<input type="checkbox" class="input-check" value="religion" name="interests"> Religion <br>
		<input type="checkbox" class="input-check" value="sport" name="interests"> Sport <br>
		<input type="checkbox" class="input-check" value="music" name="interests"> Music <br>
		<input type="checkbox" class="input-check" value="politics" name="interests"> Politics <br>
		<input type="checkbox" class="input-check" value="art" name="interests"> Art <br>
		<input type="checkbox" class="input-check" value="food" name="interests"> Food <br>
		<input type="checkbox" class="input-check" value="technology" name="interests"> Technology
    </p>

 <div class="center">
   <input type="submit" class="button theme" value="Send"><br><br>
 </div>
</form>
</div>