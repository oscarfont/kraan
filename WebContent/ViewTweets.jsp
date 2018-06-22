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
	if(session.getAttribute("user") != null){
		user = (BeanLogin) session.getAttribute("user"); 
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

<c:forEach items="${tweets}" var="tweet">
	<div class="container card white round margin"><br>
     	<!-- Button to delete or edit tweet -->
     	<c:if test="${user.user == tweet.author }">
	     	<div id="tweet-options">
	     		<div class="size">
	     			<input type="text" name="test" value="..." class="right field" readonly="readonly" />
					<ul class="right list">
						<li>Edit</li>
						<li>Delete</li>
					</ul>
				</div>
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
</c:forEach>

</body>
<script>
	(function($){
		$.fn.styleddropdown = function(){
			return this.each(function(){
				var obj = $(this)
				obj.find('.field').click(function() { //onclick event, 'list' fadein
				obj.find('.list').fadeIn(400);
				
				$(document).keyup(function(event) { //keypress event, fadeout on 'escape'
					if(event.keyCode == 27) {
					obj.find('.list').fadeOut(400);
					}
				});
				
				obj.find('.list').hover(function(){ },
					function(){
						$(this).fadeOut(400);
					});
				});
				
				obj.find('.list li').click(function() { //onclick event, change field value with selected 'list' item and fadeout 'list'
				obj.find('.field')
					.val($(this).html())
					.css({
						'background':'#fff',
						'color':'#333'
					});
				obj.find('.list').fadeOut(400);
				});
			});
		};
	})(jQuery);
	
	$(function(){
		$('.size').styleddropdown();
	});
</script>
</html>