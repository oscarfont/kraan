<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

<script type="text/javascript">
$(document).ready(function() {
    $("#LogoutController").click(function(event) {
        $('#main-page').load('ContentController',{content: $(this).attr('id')});
        document.getElementById('log-body').style.display = 'inline';
        document.getElementById('web-body').style.display = 'none';
        document.body.className = "theme-l6";
    });
});
</script>
	<a type="submit" id="LogoutController" href=# class="bar-item button padding-large theme-d4" style="float:right">Logout</a>
<br>