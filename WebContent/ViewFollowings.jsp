<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    import="models.BeanUser" pageEncoding="ISO-8859-1"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<% BeanUser[] users = (BeanUser[]) request.getAttribute("followings");

for(int i = 0; i < users.length; i++){
	System.out.println(users[i].getUser());%>
	<button id="<%=users[i].getUser()%>" class="list-user bold">@<%=users[i].getUser()%></button>
<% } %>