$(document).ready(function() {
	fadeErrors();
	fadeMessages();
	$("#distribute-asset-link").click(function() {
		$("#distribute-asset").fadeIn(600);
	});
})

function fadeErrors() {
	$('.errors').hide().fadeIn(400);
	$('.errors').delay(4000).fadeOut(400);
}

function fadeMessages() {
	$('.message').hide().fadeIn(400);
	$('.message').delay(4000).fadeOut(400);
}