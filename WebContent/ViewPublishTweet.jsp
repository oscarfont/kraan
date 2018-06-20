<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
		
<!-- Tweet -->
<div id="tweet-div" class="row-padding">
	<div class="col m12">
	  <div class="card round white">
		<div class="container padding">
		  <p id="tweet-content" contenteditable="true" class="border padding"><p id="numberofchars"></p></p>
		  <div id="tweettopics"></div> <br><button id="addTopic" class="button theme">+</button>
		  <button id="tweet-button" class="button theme"><i class="fa fa-pencil"></i>Tweet</button> 
		</div>
	  </div>
	</div>
</div>
		  
<script>
// control Tweet length
$('#tweet-content').keydown(function(event){
			
	var tweet = $('#tweet-content').text();
	
	if( 0 < tweet.length && tweet.length <= 300 && tweet != ""){
		
		document.getElementById("tweet-button").disabled = false;
		
	}else{
		
		document.getElementById("tweet-button").disabled = true;
		
	}
		
});

// print remaining chars of tweet
$('#tweet-content').keyup(function(event){
	
	var tweet = $('#tweet-content').text();
	
	var remaining = 300 - tweet.length;
	$('#numberofchars').text('remaining charachters: ' + remaining);
	
});

// publish tweet
$('#tweet-button').click(function() {
	//Publish Tweet
	var tweet = $('#tweet-content').text();
	
	if(tweet == "") return;

	var interestarray = [];
	
	var count = $("#tweettopics > select").length;
	
	for(var i = 0; i < count; i++){
		interestarray.push($('#interest_'+i).val());
	}
	
	console.log(interestarray);
	
	var interestString = interestarray.toString();
	
	var tweetcontent = $('#tweet-content').text();
	var action = 0;
	$('#tweet-content').load('TweetController', {content:action, tweet:tweetcontent, interests:interestString});
})

//add interests dropdown to a tweet
var i = 0;
$('#addTopic').click(function(event){
	var count = $("#tweettopics > select").length;
	if(count >= 0 && count < 8){
		$('#tweettopics').append("<select id='interest_"+ i +"'><option value='religion'>Religion</option><option value='sport'>Sport</option><option value='music'>Music</option><option value='politics'>Politics</option><option value='art'>Art</option><option value='food'>Food</option><option value='technology'>Technology</option></select>");
	}
	i++;
});

</script>