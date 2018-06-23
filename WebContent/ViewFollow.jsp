<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    import="models.BeanUser" pageEncoding="ISO-8859-1"%>
    
<% 
	String requestUsername = (String) request.getAttribute("own_profile");
	boolean isfollowing = true;
	if(request.getAttribute("following") != null){
		isfollowing = (boolean) request.getAttribute("following");
	}
	System.out.println(requestUsername);
%>

<div id="follow-div" class="center">
	<hr>
	<input type="button" id="follow-button" class="button theme-d5 margin-bottom" value="" onclick="follow()" style="width: 50%"></input>
</div>

<script>
function follow() {
	var tofollow = "<%=requestUsername%>";
	console.log(tofollow);
	$('#follow-div').load('FollowController', {following:tofollow});
}

$(document).ready(function() {
	
	console.log(follows);
	
	var follows = "<%=isfollowing%>";
	
	if(follows == true){
		$('#follow-button').val("Unfollow");
	}else{
		$('#follow-button').val("Follow");
	}
});

/*$('#profile-button').click(function() {
	var owner = "Yes";
    $('#main-page').load('ProfileController', {own_profile:owner});
});*/
</script>