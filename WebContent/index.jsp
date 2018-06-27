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
	  <a id="profile-button" href="#" class="bar-item button hide-small padding-large hover-white" title="User Profile"><i class="fa fa-user"></i></a>
	  <div id="logout-button" class="right">
	  	<c:if test="${user == null}">
			<jsp:include page="ViewMenuLogged.jsp" />
		</c:if>	
	  </div>
	  <input type="text" id="search-text" class="search-bar right" style="margin-right:10px" placeholder="Search user...">
      <button type="button" id="search-button" class="search-bar theme-l1 right"><i class="fa fa-search"></i></button>
    </div>
  <div id="search-done"></div>
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
	<script>$("#logout-button").show();</script>
</c:if>		  
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
		<div id="logout-msg"></div>
      	<div id="content">
       		<jsp:include page="ViewLoginForm.jsp" />			  
       	</div>
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

<!-- No session -->
<c:if test="${user == null}">
	<script>
		document.body.className = "theme-l6";
		$("#log-body").show();
		//$("#logout-button").hide();
	</script>
</c:if>	
	
</body>
<script>
$('#kraan-button').click(function() {
    location.reload();
});
$('#profile-button').click(function() {
	var owner = "Yes";
    $('#main-page').load('ProfileController', {own_profile:owner});
});
// View Time Line with button
$('#timeline-button').click(function() {
	$('#main-page').load('TimeLineController');
})

// Search users
$('#search-button').click(function() {
	console.log("HOLAAA");
	var info = $('#search-text').val();
	$('#search-done').load('SearchController',{content:info});
	//$('#search-done').append('<button>Hola!</button>'); 
})
</script>

</html>