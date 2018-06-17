<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
    
<script type="text/javascript">
$(document).ready(function() {
    $(".button").click(function(event) {
        $('#content').load('ContentController',{content: $(this).attr('id')});
    });
});
</script>

<h4 class="center">
  <input type="submit" id="RegisterController" href=# class="button" style="width:45%;background-color:#fff" value="Registration" />
  <input type="submit" id="LoginController" href=# class="button" style="width:45%;background-color:#ced4da" value="Login" />
</h4>