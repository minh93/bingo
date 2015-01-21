function changeBackGround(element) {
	element.style.backgroundImage = "url('/assets/circle_yellow.png')";
	element.style.backgroundSize = "52px 52px";
}
$(document).ready(
	function(){
		$("a#ajax_trigger").bind("ajax:success",
			function(evt,data,status,xhr){
				alert("success");
			});
	});