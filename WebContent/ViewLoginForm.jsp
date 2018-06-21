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
 
<!-- Anonymous -->
<div class="margin-top" align="center">
<small>
¿Don't you want to Register?<br>
Enter as anonymous User<br>
</small>
<a id="anonymous-button" href=# class="button margin-bottom" style="width:45%;background-color:#ced4da;margin-top:10px;">Anonymous</a>
</div>
 
</form>
</div>

<script>
//Enter Kraan as anonymous
$('#anonymous-button').click(function() {
	$("#log-body").hide();
	$("#web-body").show();
	document.body.className = "theme-l5";
	$('#main-page').load('TimeLineController');
});
</script>