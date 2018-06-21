<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<div id="search-result" class="dropdown-search display-container theme-l1 hide-small right">
  <span onclick="this.parentElement.style.display='none'" class="button theme-l3 display-topright">
    <i class="fa fa-remove"></i>
  </span>
  <c:if test="${searchUser != 'notfound'}">
	<c:forEach items="${userList}" var="us">
		<button id="${us}" class="search-user bold">@${us}</button>
	</c:forEach>
  </c:if>
  <c:if test="${searchUser == 'notfound'}">
	<div class="bold white-tag">No results found...</div>
  </c:if>
</div>

<script>
$('#search-result').click(function(){
	$('button').click(function(){
	   var uid = $(this).attr('id');
	   //alert(uid);
	   //AQUI HEMOS GUARDADO LA ID DEL BOTON CLICADO,
	   //QUE ES EL NOMBRE DEL USUARIO
	   //CAMBIAR ESTO DE ABAJO PARA QUE LINKE CON EL PERFIL
	   $('#main-page').load('TimeLineController');
	});
});
</script>