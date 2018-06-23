<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    import="models.BeanUser" pageEncoding="ISO-8859-1"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<%
	BeanUser[] users = (BeanUser[]) request.getAttribute("users");
%>

<c:forEach items="${users}" var="user">
   <button id="${user.user}" class="list-user bold">@${user.user}</button>
</c:forEach>