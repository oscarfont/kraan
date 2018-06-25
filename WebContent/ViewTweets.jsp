<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="models.BeanTweet" import="models.BeanLogin" session="true"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	BeanTweet[] tweets = (BeanTweet[]) request.getAttribute("tweets");
	BeanLogin user = null;
	String tweetsToDisplay = (String) request.getAttribute("display");
	boolean admin = false;
	if(session.getAttribute("user") != null){
		user = (BeanLogin) session.getAttribute("user");
	}
	if(session.getAttribute("admin") != null){
		admin = (boolean) session.getAttribute("admin");
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

<% if(tweets != null){ %>
	<%if(tweetsToDisplay.equals("All")){ %>
		<c:forEach items="${tweets}" var="tweet">
		<div class="container card white round margin"><br>
	     	<!-- Button to delete or edit tweet -->
	     	<c:if test="${user.user == tweet.author or admin == true}">
	     		<button id="tweet-config-button${tweet.id}" onclick="settings_button(${tweet.id})" class="fa fa-cog right"></button>
	     		<div id="tweet-config-${tweet.id}" class="right margin-right" style="display:none;z-index:2;">
					<div id="tweet-edit" class="theme-l5 right" onclick="editTweet(${tweet.id})" style="padding:10px;width:80px;margin-right:5px;text-align:center;">Edit</div>
					<div id="tweet-delete-${tweet.id}" onclick="deleteTweet(${tweet.id})" class="theme-l5 right" style="padding:10px;width:80px;margin-right:5px;text-align:center;">Delete</div>
				</div>
	       </c:if>
	       <img src="images/img_avatar2.png" alt="Avatar" class="left circle margin-right" style="width:60px">
	       <h4>${tweet.author}</h4>
	       <span class="left opacity">${tweet.date}</span><br>
	       <hr class="clear">
	       <p>${tweet.content}</p>
	       <div class="right">
		       <c:if test="${tweet.interests != null }">
			       <small>
				       <c:forEach items="${tweet.interests}" var="interest">
				       		<c:out value="#${interest} "></c:out>
				       </c:forEach>
			       </small>
		       </c:if>
	       </div>
	       <button type="button" class="button theme-d1 margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button>
	       <button type="button" class="button theme-d2 margin-bottom"><i class="fa fa-retweet"></i>  Retweet</button> 
	       <button type="button" class="button theme-d3 margin-bottom"><i class="fa fa-comment"></i>  Comment</button> 
		</div>
	</c:forEach>
	<%}else{ 
		int count = 0;
	%>
	<c:forEach items="${tweets}" var="tweet">
		<c:if test="${display == tweet.author}">
			<% count++; %>
	     	<!-- Button to delete or edit tweet -->
	     	<div class="container card white round margin"><br>
	     	<c:if test="${user.user == tweet.author or admin == true }">
					<button id="tweet-config-button${tweet.id}" onclick="settings_button(${tweet.id})" class="fa fa-cog right"></button>
	     		<div id="tweet-config-${tweet.id}" class="right margin-right" style="display:none;z-index:2;">
					<div id="tweet-edit" class="theme-l5 right" onclick="editTweet(${tweet.id})" style="padding:10px;width:80px;margin-right:5px;text-align:center;">Edit</div>
					<div id="tweet-delete-${tweet.id}" onclick="deleteTweet(${tweet.id})" class="theme-l5 right" style="padding:10px;width:80px;margin-right:5px;text-align:center;">Delete</div>
				</div>
			</c:if> 
	     	<img src="images/img_avatar2.png" alt="Avatar" class="left circle margin-right" style="width:60px">
	     	<h4>${tweet.author}</h4>
	     	<span class="left opacity">${tweet.date}</span><br>
	     	<hr class="clear">
	     	<p>${tweet.content}</p>
	     	<c:if test="${tweet.interests != null }">
	     		<p>Interests:
	     		<c:forEach items="${tweet.interests}" var="interest">
	     			<c:out value="${interest} "></c:out>
	     		</c:forEach>
	     		</p>
	     	</c:if>
	     	<button type="button" class="button theme-d1 margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button>
	     	<button type="button" class="button theme-d2 margin-bottom"><i class="fa fa-thumbs-down"></i>  Retweet</button> 
	     	<button type="button" class="button theme-d3 margin-bottom"><i class="fa fa-comment"></i>  Comment</button>
	     	</div>
	     </c:if>
	</c:forEach>
		<% if(count == 0){ %>
			<div class="card round white padding-16 center">
				<p>No tweets for now.</p>
			</div>
		<% } 
	 }
} %>



</body>
<script>
// Edit and delete tweets
function settings_button(id) {
	console.log('#tweet-config-'+id);
	$('#tweet-config-'+id).toggle();
}

function editTweet(id){
	var code = 1;
	$('#tweet_'+id).empty();
	$('#tweet_'+id).load('EditTweetController', {tweet_id:id, action:code});
}

function deleteTweet(id) {
	$('#tweet-delete-'+id).load('DeleteTweetController', {tweet_id:id});
	location.reload();
}
</script>
</html>