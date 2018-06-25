<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    import="models.BeanUser" import="models.BeanLogin" pageEncoding="ISO-8859-1"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<% BeanUser[] users = (BeanUser[]) request.getAttribute("followings");

for(int i = 0; i < users.length; i++){
	System.out.println(users[i].getUser());%>
	<button id="<%=users[i].getUser()%>" class="list-user bold" onclick="gotoProfile(this.id)">@<%=users[i].getUser()%></button>
<% } %>

<script>
function gotoProfile(id){
	<% BeanLogin checkUser = (BeanLogin) session.getAttribute("user");
	String checkUsername = checkUser.getUser(); %>
	
	var checkUsername = "<%=checkUsername%>";
	
	if(checkUsername.localeCompare(id) == 0){
		$('#main-page').load('ProfileController', {own_profile:"Yes"});
	} else {
		$('#main-page').load('ProfileController', {own_profile:id});
	}
}
</script>