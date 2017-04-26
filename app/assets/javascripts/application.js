// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require_tree .
//= require materialize-sprockets
// $(document).ready(onLoad);
$(document).on('turbolinks:load', onLoad);

function onLoad(){
  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  $('.modal').modal();
  $(".dropdown-button").dropdown();
  $('select').material_select();
  var $input = $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 2, // Creates a dropdown of 15 years to control year
    min: new Date(),
    max: new Date(2018,12,30),
    format: "ddd dd mmm, yyyy"
  });
  $('.dropdown-button').dropdown({
      inDuration: 300,
      outDuration: 225,
      constrainWidth: false, // Does not change width of dropdown to that of the activator
      hover: false, // Activate on hover
      gutter: 0, // Spacing from edge
      belowOrigin: true, // Displays dropdown below the button
      alignment: 'left', // Displays dropdown with edge aligned to the left of button
      stopPropagation: false // Stops event propagation
    }
  );
  var updateProgressBar = function(event_id, min_people, max_people, joined_count){
    var remaining_count = Number(max_people - joined_count)
    if (remaining_count == 0){
      remaining_count = "No";
      $('#join_game_' + event_id).addClass("disabled");
      $('#progress_bar_' + event_id).removeClass("green blue red");
      $('#progress_bar_' + event_id).addClass("red");
    }
    $('#remaining_count_' + event_id).text('' + remaining_count);
    if (joined_count <= min_people){
      $('#joined_count_' + event_id).text('' + joined_count);
      var width = ((joined_count / min_people) * 100).toString() + "%";
      $('#progress_bar_' + event_id).css("width", '' + width);
      if (joined_count == min_people && min_people != max_people){
        $('#progress_bar_' + event_id).removeClass("blue green red");
        $('#progress_bar_' + event_id).addClass("green");
      } else if(joined_count < min_people) {
        $('#progress_bar_' + event_id).removeClass("blue green red");
        $('#progress_bar_' + event_id).addClass("blue");
      }
    }
  }
  $(".card-button").on("click",".join-game-button",function(){
    var event_id = $(this).attr("data-event-id");
    var user_id = $(this).attr("data-user-id");
    var min_people = Number($('#min_people_' + event_id).text());
    var max_people = Number($('#remaining_count_' + event_id).attr("data-max-people"));
    $.ajax({
     url: '/events/' + event_id + '/players',
     type: "POST",
     dataType : 'json',
     success: function(response) {
      //console.log(response);
      $button = $("<button>").attr("data-event-id",event_id).attr("data-user-id",user_id).attr("id",'withdraw_game_' + event_id).addClass("withdraw-game-button waves-effect waves-light btn red lighten-1 no-uppercase").text("Withdraw");
      if ($('#host_name_' + event_id).attr("data-host-id") == user_id)
        $button.addClass("disabled");
      $button.append("<i class=\"material-icons left\" style=\"vertical-align: middle;\">remove_circle_outline</i>")
      $('#join_game_' + event_id).replaceWith($button);
      updateProgressBar(event_id, min_people, max_people, response.joined_count)
    },
    error: function(error) {
      console.log(error);
    }
   });
  });
  $(".card-button").on("click",".withdraw-game-button", function() {
    var event_id = $(this).attr("data-event-id");
    var user_id = $(this).attr("data-user-id");
    var min_people = Number($('#min_people_' + event_id).text());
    var max_people = Number($('#remaining_count_' + event_id).attr("data-max-people"));
    $.ajax({
      url: '/events/' + event_id + '/players/' + user_id,
      type: 'DELETE',
      dataType: 'json',
      success: function(response) {
        //console.log(response);
        $button = $("<button>").attr("data-event-id",event_id).attr("data-user-id",user_id).attr("id",'join_game_' + event_id).addClass("join-game-button waves-effect waves-light btn green no-uppercase").text("Join Game");
        $button.append("<i class=\"material-icons left\" style=\"vertical-align: middle;\">person_add</i>")
        $('#withdraw_game_' + event_id).replaceWith($button);
        updateProgressBar(event_id, min_people, max_people, response.joined_count)
      },
      error: function(error) {
        console.log(error);
      }
    });
  });
  $("#edit-close-button").click(function(){
    $("#event-edit-form").css("display","none");
  });

  $("#delete-close-button").click(function(){
    $('#delete-event-model').modal('close');
  });

  $("#edit-form-button").click(function(){
    $('#event-edit-form').toggle();
  })
  $("#delete-form-button").click(function(){
    $('#delete-event-model').modal('open');
  })
  $("#save-event-form").click(function(){
    if ($("#event-start-date").val() == ''){
      Materialize.toast("Date cannot be empty!",3000,"red");
      return false;
    }
    if($("#event-start-time").val() == ''){
      Materialize.toast("Time cannot be empty!",3000,"red");
      return false;
    }
    if ($("#event-location").val() == ''){
      Materialize.toast("Location cannot be empty!",3000,"red");
      return false;
    }
    var event_id = $(this).attr("data-event-id");
    $.ajax({
      url:'/events/'+event_id,
      method: "PATCH",
      dataType: "json",
      data:{
        event_id: event_id,
        event_start_date: $("#event-start-date").val(),
        event_start_time: $("#event-start-time").val(),
        event_details: $("#event-details").val(),
        event_location: $("#event-location").val(),
        event_address: $("#event-address").val(),
        event_lat: $("#event-lat").val(),
        event_lng: $("#event-lng").val()
      },
      success: function(response) {
        Materialize.toast(response.message, 3000, "blue");
        $("#event-edit-form").css("display","none");
      },
      error: function(response){
        Materialize.toast(response.message, 3000, "red");
      }
    });
  })

  $("#delete-event-button").click(function(){
    if($("#cancel-event-reason").val() == ''){
      Materialize.toast("Reason can not be empty.", 2000, "red");
      return false;
    }
    var event_id = $(this).attr("data-event-id");
    $.ajax({
      url:'/events/'+event_id,
      method:'DELETE',
      dataType: 'json',
      success: function(){
        $("#delete-event-model").modal('close');
        Materialize.toast("Event deleted.",2000,"blue");
        document.location.href="/events";
      },
      error: function(){
        Materialize.toast("Internal Server Error",2000,"red");
      }
    })
  })
}



