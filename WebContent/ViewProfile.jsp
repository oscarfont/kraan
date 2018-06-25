<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	import="models.BeanUser" import="models.BeanLogin" import="utils.DAO" session="true"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
 
<% BeanUser user = (BeanUser) request.getAttribute("user"); 
BeanLogin userLogin = (BeanLogin) session.getAttribute("user");
String sessionUsername = userLogin.getUser();
String requestUsername = user.getUser();

boolean admin = false;
String owner = "Yes";
String isOwner = (String) request.getAttribute("own_profile");

if(session.getAttribute("admin") != null){
	admin = (boolean) session.getAttribute("admin"); 
}

%>
  
<script type="text/javascript">
$(document).ready(function() {
	    $.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
	    document.getElementById('log-body').style.display = 'none';
	    //$('#logout-button').load('MenuController');
	    document.getElementById('web-body').style.display = 'inline';
	    document.body.className = "theme-l5";
	
	    var tweetstoDisplay = <%=isOwner%>;
	    var tweetstoDisplay = "<%=requestUsername%>";
	    $('#tweets-container').load("GetTweetsController", {Display:tweetstoDisplay});
});
</script>

<script>
var tofollow = "<%=isOwner%>";
$('#follow-div').load('FollowController', {following:tofollow,checking:"Yes"});

$('#showFollowing').load('GetFollowController', {currentUser:tofollow,option:'following'});
$('#showFollowers').load('GetFollowController', {currentUser:tofollow,option:'followers'});
</script>

<script>
<% if(isOwner.equals("Yes")) {
	if(admin == true) { %>
		//test admin
		$('#welcome').load('AdminController');
	<% }
} %>
</script>

<!-- Page Container -->
<div id="login-content">
	<div class="container content" style="max-width:1400px;margin-top:80px">    
	  <!-- The Grid -->
	  <div class="row">
	    <!-- Left Column -->
	    <div class="col m3" id="userProfile">
	      <!-- Profile -->
	      <div class="card round white">
	        <div class="container">
	         <h4 class="center">Welcome ${user.name}!</h4>
	         <div class="center" id="welcome"></div>
	         <p class="center"><img src="images/img_avatar2.png" class="circle" style="height:106px;width:106px" alt="Avatar"></p>
	         <hr>
	         <p><i class="fa fa-pencil fa-fw margin-right text-theme"></i>
				<%if(user.getJob().equals("")){ %>
					<%if(user.getUser().equals(userLogin.getUser())){ %>
						Add a job description
						<a id="modificar-job" href="#" class="bar-item button hide-small padding-large hover-white" title="Add a job description" onclick="modifyProfile()"><i class="fa fa-plus-square fa-fw text-theme"></i></a>
					<%} else{ %>
						No Job description
					<%} %>
						
				<%} else{ %>
					${user.job }
				<%} %>

	         <p><i class="fa fa-home fa-fw margin-right text-theme"></i>
				<%if(user.getLocation().equals("")){ %>
					<%if(user.getUser().equals(userLogin.getUser())){ %>
						Add a location description
						<a id="modificar-location" href="#" class="bar-item button hide-small padding-large hover-white" title="Add a location description"onclick="modifyProfile()"><i class="fa fa-plus-square fa-fw text-theme"></i></a>
					<%}else{ %>
						No Location description
					<%} %>
				<%} else{ %>
					${user.location}
				<%} %>
	         </p>
	         <p><i class="fa fa-birthday-cake fa-fw margin-right text-theme"></i>
	         	<%if(user.getBirthdate().equals("")){ %>
					<%if(user.getUser().equals(userLogin.getUser())){ %>
						Add your birth date
						<a id="modificar-birthdate" href="#" class="bar-item button hide-small padding-large hover-white" title="Add your birth date"onclick="modifyProfile()"><i class="fa fa-plus-square fa-fw text-theme"></i></a>
					<%}else{ %>
						No Birth Date information
					<%} %>
				<%} else{ %>
					${user.birthdate}
				<%} %>
				</p>
	        </div>
	        <%if((user.getUser().equals(userLogin.getUser()) || admin)){ %>
	        <hr>
	        <div class="center">
	        	<div class="container" id="edit-profile">
	         	<button type="button" class="button theme-d1 margin-bottom"onclick="modifyProfile()"><i class="fa fa-edit"></i>  Edit Profile</button>
	         	</div>
	         </div>
	         <%} %>
	      </div>
	      <br>
	      
	     <!-- User Description --> 
	      <div class="card round white hide-small">
	        <div class="container">
	          <p><b>Description</b></p>
	          <p>
				<%if(user.getDescription().equals("")){ %>
					<%if(user.getUser().equals(userLogin.getUser())){ %>
						Want to add a description?
						<a id="modificar-info" href="#" class="bar-item button hide-small padding-large hover-white" title="Add User description"><i class="fa fa-plus-square fa-fw text-theme"></i></a>
					<%}else{ %>
						No description for this user
					<%} %>
				<%} else{ %>
					${user.description}
				<%} %>
	          </p>
			 <% if(!isOwner.equals("Yes")){ %>
				<div id="follow-div" class="center"></div>
			 <% } %>
			</div> 
	      </div>
	      <br>
	
		  <!-- Followers and followings list -->
	      <div class="card round">
	        <div class="white">
	          <button id="showFollowingButton" onclick="dropdown('showFollowing')" class="button block theme-l1 left-align"><i class="fa fa-star fa-fw margin-right"></i> Following</button>
	          <div id="showFollowing" class="hide container"></div>
	          <button id="showFollowersButton" onclick="dropdown('showFollowers')" class="button block theme-l1 left-align"><i class="fa fa-users fa-fw margin-right"></i> Followers</button>
	          <div id="showFollowers" class="hide container"></div>
	        </div>    
	      </div>
	      <br>
	      
	      <!-- Interests list --> 
	      <div class="card round white hide-small">
	        <div class="container">
	          <p>Interests</p>
	          <p>
				<%if(user.getInterests() != null){ 
					for(String interest : user.getInterests()){ %>
					<span class="tag small theme-d2"><%=interest%></span>
					<%}
					}else{
						if(user.getUser().equals(userLogin.getUser())){%>
							Add your interests!
							<a id="modificar-info" href="#" class="bar-item button hide-small padding-large hover-white" title="Add your Interests" onclick="modifyProfile()"><i class="fa fa-plus-square fa-fw text-theme"></i></a>
						<%}
					}%>
	          </p>
	        </div>
	      </div>
	      <br>
	    
	    <!-- End Left Column -->
	    </div>
	    
	    <!-- Middle Column -->
	    <div class="col m7">
	      
	     <div id="tweets-container"></div>
	     <div id="modifyProfile-container" style="display:none"></div>	
	      
	    <!-- End Middle Column -->
	    </div>
	    
	    <!-- Right Column -->
	    <div class="col m2">	      
	      <div class="card round white padding-16 center">
	        <img src="images/ad1.jpg" class="opacity" style="width:90%">
	      </div>
	      <br>
	      
	      <div class="card round white padding-16 center">
	        <img src="images/ad2.jpg" class="opacity" style="width:90%">
	      </div>
	      <br>
	      
	    <!-- End Right Column -->
	    </div>
	    
	  <!-- End Grid -->
	  </div>
	  
	<!-- End Page Container -->
	</div>
	<br>
	
	<!-- Footer -->
	<footer class="container theme-d3 padding-16">
	  <h5>&copy; EPAW, 2018.</h5>
	  <small>Marc Canal, Óscar Font & Lucía Gasión.</small>
	</footer>
</div>

<script>
function modifyProfile() {
	document.getElementById('tweets-container').style.display = 'none';
	document.getElementById('modifyProfile-container').style.display = 'inline';
	 var usertomodify = "<%=requestUsername%>";
	$('#modifyProfile-container').load('ModifyProfileController', {username:usertomodify});
}
</script>


<script>
// Accordion
function dropdown(id) {
    var x = document.getElementById(id);
    if (x.className.indexOf("show") == -1) {
        x.className += " show";
        x.previousElementSibling.className += " theme-d1";
    } else { 
        x.className = x.className.replace("show", "");
        x.previousElementSibling.className = 
        x.previousElementSibling.className.replace(" theme-d1", "");
    }
};

// Used to toggle the menu on smaller screens when clicking on the menu button
function openNav() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("show") == -1) {
        x.className += " show";
    } else { 
        x.className = x.className.replace(" show", "");
    }
};
</script>


<script>
//Enter Kraan as anonymous
$('#add-job').click(function() {
	$("#log-body").hide();
	$("#web-body").show();
	document.body.className = "theme-l5";
	$('#main-page').load('TimeLineController');
});
</script>


<script>
function follow() {
	var tofollow = "<%=isOwner%>";
	$('#follow-div').load('FollowController', {following:tofollow});
}
</script>