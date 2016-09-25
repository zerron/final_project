<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value='/js/jquery.min.js' />"></script>
<script>
	$(function() {
		var socket = new WebSocket(
				'ws://${pageContext.request.getServerName()}:${pageContext.request.getServerPort()}${pageContext.request.contextPath}/websocket');
		socket.onmessage = function(event) {
			addMessage(event.data);
		};
		socket.onclose = function(event) {
			alert(event.code);
		};
		
		$(document).keydown(function(e){
			if(e.which == 13 || e.keyCode == 13){
				sendMessage();
			}
		});

		$('#send').on('click', function(){
			sendMessage();
		});
		
		function sendMessage() {
			var msg = $('#message').val();
			var name = "${Login.name}";
			if(msg != "") {
				socket.send(JSON.stringify({
					content : msg,
					nickname : name
				}));
			}
		}

		function addMessage(message) {
			message = JSON.parse(message);
			var messageItem = '<li style="margin-bottom:5px;">' + '<div>' + '<header>' 
					+ message.nickname + ": " + message.content + '</header>' + '</div>' 
					+ '<div style="font-size:10px;"><time>' + message.date + '</time>' + '</div>'
					+ '</li>';
			$(messageItem).appendTo('#message_content');
			$('#chart_content').scrollTop($('#chart_content').prop("scrollHeight"));
		}
	});
</script>

<title>Chat Room - GUEMI</title>
</head>
<body>
	<div>
		<h1>Chart Room</h1>
	</div>


	<div id="chart_content" style="overflow: auto; height: 300px; width: 800px; border: solid 1px;">
		<ul id="message_content" style="list-style-type:none; font-size:18px;"></ul>
	</div>

	
	
	<div id="message_input">
		<div style="display:inline;">
			<input id="message" name="message" type="text" style="width:300px;"/>
		</div>
		<div id="send_button" style="display:inline;">
			<input id="send" type="button" value="send" />
		</div>
	</div>
	






</body>
</html>