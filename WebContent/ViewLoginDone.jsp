<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="models.BeanUser" session="true"%>
  
<div id="timeline-div"></div>

<script type="text/javascript">
$(document).ready(function() {
	    $.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
	    document.getElementById('log-body').style.display = 'none';
	    $('#timeline-div').load('TimeLineController');
	    document.getElementById('web-body').style.display = 'inline';	    
	    document.body.className = "theme-l5";

});
</script>
