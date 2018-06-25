<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<script type="text/javascript">
$(document).ready(function() {
	    $.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
	    document.getElementById('log-body').style.display = 'none';
	    document.getElementById('web-body').style.display = 'inline';
	    document.body.className = "theme-l5";
	    $('#tweets-container').load("GetTweetsController");
});
</script>

<link rel="stylesheet"type="text/css"  href="css/style.css">

<!-- Page Container -->
<div id="timeline-content">
	<div class="container content" style="max-width:1400px;margin-top:80px">    
	  <!-- The Grid -->
	  <div class="row">
	    <!-- Left Column -->
	    <div class="col m3">
	    <p> Left Column of timeline </p>  
	      <!-- Interests --> 
	      <div class="card round white hide-small">
	        <div class="container">
	          <p>Interests</p>
	          <p>
	            <span class="tag small theme-d5">Religion</span>
	            <span class="tag small theme-d4">Sport</span>
	            <span class="tag small theme-d3">Music</span>
	            <span class="tag small theme-d2">Politics</span>
	            <span class="tag small theme-d1">Art</span>
	            <span class="tag small theme">Food</span>
	            <span class="tag small theme-l1">Technology</span>
	          </p>
	        </div>
	      </div>
	      <br>
	    <!-- End Left Column -->
	    </div>
	    
	    <!-- Middle Column -->
	    <div class="col m7">
		<p> Middle Column of timeline </p>
		
		<!-- Tweet -->
		<c:if test="${user != null}">
			<jsp:include page="ViewPublishTweet.jsp" />
		</c:if>
		
		<div id="tweets-container"></div>	
	      
	    <!-- End Middle Column -->
	    </div>
	    
	    <!-- Right Column -->
	    <div class="col m2">
	    <p> Right Column of timeline </p>   
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
	  <h5>Footer</h5>
	</footer>
	 
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
	
	$(document).ready(function() {
		$('#logout-button').load('MenuController');
	});
	</script>
	
</div>