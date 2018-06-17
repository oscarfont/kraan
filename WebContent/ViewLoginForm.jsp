<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="models.BeanLogin" session="false"%>

<script>
$(document).ready(function(){
	$( "#loginForm" ).submit(function( event ) {
		  /* DEBUG
		  alert( "HOLAAA" );*/
		  event.preventDefault();
		  $('#main-page').load('LoginController',$("#loginForm").serialize());
	});
});
</script>

<% 
	BeanLogin user = null;
	if (request.getAttribute("user")!=null) {
		user = (BeanLogin)request.getAttribute("user");
	}
	else {
		user = new BeanLogin();
	}
%>

<!-- Login -->
<div id="login-form">
<form id="loginForm" action="" method="POST">

	<p>
	  <label> Username </label>
	  <input type="text" name="user" id="user" class="input-text" value="<%=user.getUser() %>" required />
	</p>
	
	<% 	
		if ( user.getError() == 1 )
			out.println("<small style='color:Tomato'>Incorrect username or password!</small>");
	%>
	
	<p>
	  <label> Password </label>
	  <input type="password" name="password" id="password" class="input-text" value="<%=user.getPassword() %>" required/>
	</p>
	
 <div class="center">
   <input type="submit" class="button theme" value="Send"><br><br>
 </div>
</form>
</div>