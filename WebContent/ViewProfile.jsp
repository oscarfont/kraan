<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="models.BeanUser" import="models.BeanLogin" session="true"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
 
<% BeanUser user = (BeanUser) request.getAttribute("user"); 
BeanLogin userLogin = (BeanLogin) session.getAttribute("user");

String admin = null;
String sessionUsername = userLogin.getUser();
String requestUsername = user.getName();

if(session.getAttribute("admin") != null){
	admin = session.getAttribute("admin").toString(); 
};
%>
  
<script type="text/javascript">
$(document).ready(function() {
	    $.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
	    document.getElementById('log-body').style.display = 'none';
	    $('#logout-button').load('MenuController');
	    document.getElementById('web-body').style.display = 'inline';
	    document.body.className = "theme-l5";
	    var tweetstoDisplay = "Oriolet"
	    $('#tweets-container').load("GetTweetsController", {Display:tweetstoDisplay});
});
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
	        <%if(user.getUser().equals(userLogin.getUser())){ %>
	        <hr>
	        <div class="container" id="edit-profile">
	         <button type="button" class="button theme-d1 margin-bottom"onclick="modifyProfile()"><i class="fa fa-edit"></i>  Edit Profile</button>
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
	        </div>
	      </div>
	      <br>
	
	      <!-- Accordion -->
	      <div class="card round">
	        <div class="white">
	          <button onclick="myFunction('Demo1')" class="button block theme-l1 left-align"><i class="fa fa-circle-o-notch fa-fw margin-right"></i> My Groups</button>
	          <div id="Demo1" class="hide container">
	            <p>Some text..</p>
	          </div>
	          <button onclick="myFunction('Demo2')" class="button block theme-l1 left-align"><i class="fa fa-calendar-check-o fa-fw margin-right"></i> My Events</button>
	          <div id="Demo2" class="hide container">
	            <p>Some other text..</p>
	          </div>
	          <button onclick="myFunction('Demo3')" class="button block theme-l1 left-align"><i class="fa fa-users fa-fw margin-right"></i> My Photos</button>
	          <div id="Demo3" class="hide container">
	         <div class="row-padding">
	         <br>
	           <div class="half">
	             <img src="images/img_avatar2.png" style="width:100%" class="margin-bottom">
	           </div>
	           <div class="half">
	             <img src="images/img_avatar2.png" style="width:100%" class="margin-bottom">
	           </div>
	           <div class="half">
	             <img src="images/img_avatar2.png" style="width:100%" class="margin-bottom">
	           </div>
	           <div class="half">
	             <img src="images/img_avatar2.png" style="width:100%" class="margin-bottom">
	           </div>
	           <div class="half">
	             <img src="images/img_avatar2.png" style="width:100%" class="margin-bottom">
	           </div>
	           <div class="half">
	             <img src="images/img_avatar2.png" style="width:100%" class="margin-bottom">
	           </div>
	         </div>
	          </div>
	        </div>    
	      </div>
	      <br>
	      
	      <!-- Interests --> 
	      <div class="card round white hide-small">
	        <div class="container">
	          <p>Interests</p>
	          <p>
	          <%for(String interest : user.getInterests()){ %>
	            <span class="tag small theme-d2"><%=interest%></span>
	            <%} %>
	          </p>
	        </div>
	      </div>
	      <br>
	      
	      <!-- Alert Box -->
	      <div class="container display-container round theme-l4 border theme-border margin-bottom hide-small">
	        <span onclick="this.parentElement.style.display='none'" class="button theme-l3 display-topright">
	          <i class="fa fa-remove"></i>
	        </span>
	        <p><strong>Hey!</strong></p>
	        <p>People are looking at your profile. Find out who.</p>
	      </div>
	    
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
	      <div class="card round white center">
	        <div class="container">
	          <p>Upcoming Events:</p>
	          <img src="images/img_avatar2.png" alt="Forest" style="width:100%;">
	          <p><strong>Holiday</strong></p>
	          <p>Friday 15:00</p>
	          <p><button class="button block theme-l4">Info</button></p>
	        </div>
	      </div>
	      <br>
	      
	      <div class="card round white center">
	        <div class="container">
	          <p>Friend Request</p>
	          <img src="images/img_avatar2.png" class="circle" alt="Avatar" style="width:50%"><br>
	          <span>Jane Doe</span>
	          <div class="row opacity">
	            <div class="half">
	              <button class="button block green section" title="Accept"><i class="fa fa-check"></i></button>
	            </div>
	            <div class="half">
	              <button class="button block red section" title="Decline"><i class="fa fa-remove"></i></button>
	            </div>
	          </div>
	        </div>
	      </div>
	      <br>
	      
	      <div class="card round white padding-16 center">
	        <p>ADS</p>
	      </div>
	      <br>
	      
	      <div class="card round white padding-32 center">
	        <p><i class="fa fa-bug xxlarge"></i></p>
	      </div>
	      
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
	$('#modifyProfile-container').load('ModifyProfileController');
}
</script>


<script>
// Accordion
function myFunction(id) {
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


<c:if test="${sessionUsername == requestUsername}">
	<script>
		//test admin
		$(document).ready(function() {
			$('#welcome').load('AdminController');
		});
	</script>
</c:if>	

	

