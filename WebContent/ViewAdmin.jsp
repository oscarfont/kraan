<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<% 
	String user = null;
	if(session.getAttribute("user") != null){
		user = session.getAttribute("user").toString(); 
	}
%>

<small>-- ADMINISTRATOR --</small>