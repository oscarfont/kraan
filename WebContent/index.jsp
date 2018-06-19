<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<!DOCTYPE html>
<html>
<head>
  <title>Kraan</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet"type="text/css"  href="css/style.css">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="shortcut icon" href="images/kraan.ico" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js"> </script>
</head>

<% 
	String user = null;
	if(session.getAttribute("user") != null){
		user = session.getAttribute("user").toString(); 
	}

%>

<body>

<!-- Logged -->
<div id="web-body" style="display:none">
	<!-- Navbar -->
	<div class="top">
	 <div class="bar theme-d2 left-align large">
	  <a class="bar-item button hide-medium hide-large right padding-large hover-white large theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
	  <a href="#" class="bar-item button padding-large theme-d4" id="kraan-button"><i class="fa fa-home margin-right"></i>Kraan</a>
	  <a id="timeline-button" href="#" class="bar-item button hide-small padding-large hover-white" title="TimeLine"><i class="fa fa-globe"></i></a>
	  <a id="profile-button" href="#" class="bar-item button hide-small padding-large hover-white" title="Account Settings"><i class="fa fa-user"></i></a>
	  <a href="#" class="bar-item button hide-small padding-large hover-white" title="Messages"><i class="fa fa-envelope"></i></a>
	  <div class="dropdown-hover hide-small">
	    <button class="button padding-large" title="Notifications"><i class="fa fa-bell"></i><span class="badge right small green">3</span></button>     
	    <div class="dropdown-content card-4 bar-block" style="width:300px">
	      <a href="#" class="bar-item button">One new friend request</a>
	      <a href="#" class="bar-item button">John Doe posted on your wall</a>
	      <a href="#" class="bar-item button">Jane likes your post</a>
	    </div>
	  </div>
	  <div id="logout-button" style="float:right"></div>
	 </div>
	</div>
  	<div id="main-page">
  		<!-- Check if session exists -->
		<c:if test="${user != null}">
			<script>
				if($('#login-content').length) {
					$('#login-content').remove();
				}
			</script>
			<jsp:include page="ViewLoginDone.jsp" />
		</c:if>		  
   	</div>
</div>

<!-- Include the login register menu only if there is no session -->

<!-- Not Logged -->
<div id="log-body" class="container content" style="max-width:1400px;margin-top:80px;display:none">    
  <!-- The Grid -->
  <div class="row">
  
    <!-- Left Column -->
    <div class="col m4">
      <div class="card round white">
        <div class="container"></div>
      </div>
    </div>

    <!-- Middle Column -->
    <div class="col m4">
	  <div class="center"><img src="images/kraan_logo2.png" style="max-width:250px"/></div>
      <div class="container card white round margin">
        <div id="navigation">
	    	<jsp:include page="ViewMenuNotLogged.jsp" />   
		</div>
      	<div id="content">
       		<jsp:include page="ViewLoginForm.jsp" />			  
       	</div>
	  </div>
	  <div align="center">
			<small style='color:White'>¿Don't you want to Register?</small>
			<small style='color:White'>Enter as anonymous User</small><br><br>
			<a id="anonymous-button" href=# class="button" style="width:45%;background-color:#ced4da">Anonymous</a>
			<br><br><br>
	  </div>
    </div>
    
    <!-- Right Column -->
    <div class="col m4">
      <div class="card round white">
        <div class="container"></div>
      </div>
    </div>
    
  <!-- End Grid -->
  </div>
<!-- End Page Container -->
</div>		


<c:if test="${user == null}">
	<script>
		document.body.className = "theme-l6";
		//document.getElementById('log-body').style = 'inline';
		$("#log-body").show();
	</script>
</c:if>	
	
</body>
<script>
$('#kraan-button').click(function() {
	//ESTO ESTA GIÑAO
    location.reload();
});

$('#profile-button').click(function() {
    $('#main-page').load('ProfileController');
});

// Enter Kraan as anonymous
$('#anonymous-button').click(function() {
	$("#log-body").hide();
	$("#web-body").show();
	document.body.className = "theme-l5";
	$('#main-page').load('TimeLineController');
});

// View Time Line with button
$('#timeline-button').click(function() {
	$('#main-page').load('TimeLineController');
})
</script>

</html>