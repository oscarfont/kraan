<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

<script type="text/javascript">
$(document).ready(function() {
	    $.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
	    document.getElementById('log-body').style.display = 'none';
	    document.getElementById('web-body').style.display = 'inline';
	    document.body.className = "theme-l5";
});
</script>
    
    <% System.out.println("TimeLine.jsp"); %>
	
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

		<div class="row-padding">
	        <div class="col m12">
	          <div class="card round white">
	            <div class="container padding">
	              <p contenteditable="true" class="border padding">Status: Feeling Blue</p>
	              <button id="tweet-button" class="button theme"><i class="fa fa-pencil"></i>Tweet</button> 
	            </div>
	          </div>
	        </div>
	      </div>
		  
	      <div class="container card white round margin"><br>
	        <img src="images/img_avatar2.png" alt="Avatar" class="left circle margin-right" style="width:60px">
	        <span class="right opacity">1 min</span>
	        <h4>John Doe</h4><br>
	        <hr class="clear">
	        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
	          <div class="row-padding" style="margin:0 -16px">
	            <div class="half">
	              <img src="images/img_avatar2.png" style="width:100%" alt="Northern Lights" class="margin-bottom">
	            </div>
	            <div class="half">
	              <img src="images/img_avatar2.png" style="width:100%" alt="Nature" class="margin-bottom">
	          </div>
	        </div>
	        <button type="button" class="button theme-d1 margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button>
	        <button type="button" class="button theme-d2 margin-bottom"><i class="fa fa-thumbs-down"></i>  Dislike</button> 
	        <button type="button" class="button theme-d3 margin-bottom"><i class="fa fa-comment"></i>  Comment</button> 
	      </div>
	      
	      <div class="container card white round margin"><br>
	        <img src="images/img_avatar2.png" alt="Avatar" class="left circle margin-right" style="width:60px">
	        <span class="right opacity">16 min</span>
	        <h4>Jane Doe</h4><br>
	        <hr class="clear">
	        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
	        <button type="button" class="button theme-d1 margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button>
	        <button type="button" class="button theme-d2 margin-bottom"><i class="fa fa-thumbs-down"></i>  Dislike</button> 
	        <button type="button" class="button theme-d3 margin-bottom"><i class="fa fa-comment"></i>  Comment</button>
	      </div>  
	
	      <div class="container card white round margin"><br>
	        <img src="images/img_avatar2.png" alt="Avatar" class="left circle margin-right" style="width:60px">
	        <span class="right opacity">32 min</span>
	        <h4>Angie Jane</h4><br>
	        <hr class="clear">
	        <p>Have you seen this?</p>
	        <img src="images/img_avatar2.png" style="width:100%" class="margin-bottom">
	        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
	        <button type="button" class="button theme-d1 margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button>
	        <button type="button" class="button theme-d2 margin-bottom"><i class="fa fa-thumbs-down"></i>  Dislike</button> 
	        <button type="button" class="button theme-d3 margin-bottom"><i class="fa fa-comment"></i>  Comment</button>
	      </div> 
	      
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
	</script>
	
</div>

<script>

</script>