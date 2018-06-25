<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="models.BeanTweet" %>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="java.sql.Date"%>
    
<% 
	BeanTweet tweet = null;
	String tweet_content = new String();
	java.sql.Date new_date = new java.sql.Date(0);
	String[] interests = {"hola"};
	int id = 0;
	if(request.getAttribute("tweet") != null){
		tweet = (BeanTweet) request.getAttribute("tweet");
		tweet_content = tweet.getContent();
		long time = System.currentTimeMillis();
		new_date = new java.sql.Date(time);
		interests = tweet.getInterests();
		id = tweet.getId();
	}
	String interest_array = "[";
	for(int i = 0; i < interests.length; i++){
		if(i == interests.length - 1){
			interest_array += "'" + interests[i];
		}else{
			interest_array += "'" + interests[i] + "',";
		}
	}
	interest_array += "]";
%>
		
<!-- Tweet -->
<div id="tweet-edit-div" class="row-padding">
 <div id="tweet-edit-box">
  <p id="tweet-edit-content" contenteditable="true" class="border padding"><p id="numberofchars"></p>
  <div id="tweettopics-edit"></div>
  <div class="margin-bottom margin-top">
	  <button id="addTopic-edit" class="button theme">+</button>
	  <button id="tweet-edit" class="button theme"><i class="fa fa-pencil"></i>Edit</button> 
  </div> 
 </div>
</div>
		  

<script>
	var tweetid = "<%=id%>";
	var i = 0;
	$(document).ready(function(){
		
		var content = "<%=tweet_content%>";
		console.log(tweetid);
		$('tweet-edit-content').html(content);
		
		// process Interests
		var interests_string = "<%=interest_array%>";
		interests_string = interests_string.replace("[","");
		interests_string = interests_string.replace("]","");
		var interests = interests_string.split(",");
		
		console.log(interests);
		
		for(i = 0; i < interests.length; i++){
			interests[i] = interests[i].replace("'","");
			interests[i] = interests[i].replace("'","");
			var interest_id = '#'+interests[i] + i;
			$('#tweettopics-edit').append("<select id='interest_"+ i +"'><option id='religion"+ i +"' value='religion'>Religion</option><option id='sport"+ i +"' value='sport'>Sport</option><option id='music"+ i +"' value='music'>Music</option><option id='politics"+ i +"' value='politics'>Politics</option><option id='art"+ i +"' value='art'>Art</option><option id='food"+ i +"' value='food'>Food</option><option id='technology"+ i +"' value='technology'>Technology</option></select>");
			$(interest_id).attr("selected", 'selected');
		}
	});
	
	$('#tweet-edit').click(function(){
		
		var code = 0;
		var tweet = $('#tweet-edit-content').text();
		var interestarray = [];
		
		var count = $("#tweettopics-edit > select").length;
		
		for(var j = 0; j < count; j++){
			interestarray.push($('#interest_'+j).val());
		}
		
		console.log(interestarray);
		
		var interestString = interestarray.toString();
		$('#tweet_'+tweetid).load('EditTweetController', {action:code, new_content:tweet , new_interests:interestString, tweet_id:tweetid});
		location.reload();
	});
	
	//add interests dropdown to a tweet
	$('#addTopic-edit').click(function(event){
		var count = $("#tweettopics-edit > select").length;
		if(count >= 0 && count < 8){
			$('#tweettopics-edit').append("<select id='interest_"+ i +"'><option value='religion'>Religion</option><option value='sport'>Sport</option><option value='music'>Music</option><option value='politics'>Politics</option><option value='art'>Art</option><option value='food'>Food</option><option value='technology'>Technology</option></select>");
		}
		i++;
	});
</script>