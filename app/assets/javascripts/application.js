// This is a manifest file that"ll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It"s not advisable to add code directly here, but if you do, it"ll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

function init(){
  $.ajax({url: "deal/update", type: "POST", data: {authenticity_token: $("input[name=authenticity_token]").val()}, success: function(result){
    var str = "";
    for(var x in result){	
      str += result[x]["name"] + "---" +result[x]["updated"] + "---";
      if(result[x]["bingo"]) 
        str += "<strong>BINGO!!! </strong><br>";
      if(!result[x]["bingo"] && result[x]["reach"])
        str += "REACH!!! <br>";
    }
    $("#log_event").html(str);
  }});
}

function startTimer(){
  setInterval("init()", 5000);
}

function updateDealNumbers(){
  $("#response").html("&nbsp");
  $.ajax({url: "/player/update", type: "POST",data: {type_of_action: "update_deal_numbers", authenticity_token: $("input[name=authenticity_token]").val()}, success: function(result){
    var str = "";
    for(var x in result){	
      str += result[x] + ", ";
    }
    $("#spoke_number").html(str);
  }});
}

function startUpdateDeal(){
  setInterval("updateDealNumbers()", 5000);
}

startTimer();
startUpdateDeal();
