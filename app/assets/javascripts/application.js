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

$(document).ready(function(){
  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  $('.modal').modal();
  $(".dropdown-button").dropdown();
  $('select').material_select();
  $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 2, // Creates a dropdown of 15 years to control year
    min: new Date(),
    max: new Date(2018,12,30),
  });

$(".join-game-button").click(function() {
    //var $this = $(this);
    console.log($(this)[0].value);
    const event_id = $(this)[0].value;
    const min_people = Number($(`#min_people_${event_id}`).text())
    $.ajax({
     url: `/events/${event_id}`,
     type: "PATCH",
     dataType : 'json',
     success: function(response) {
        console.log(response);
        remaining_count = Number(response.max_people - response.joined_count)
        if (remaining_count == 0){
          remaining_count = "No";
          $(`#join_game_${event_id}`).addClass("disabled");
          $(`#progress_bar_${event_id}`).removeClass("green blue");
          $(`#progress_bar_${event_id}`).addClass("red");
        }
        $(`#remaining_count_${event_id}`).text(`${remaining_count}`);
        if (response.joined_count <= min_people){
          $(`#joined_count_${event_id}`).text(`${response.joined_count}`);
          const width = ((response.joined_count / min_people) * 100).toString() + "%";
          $(`#progress_bar_${event_id}`).css("width", `${width}`);
          if (response.joined_count == min_people){
            $(`#progress_bar_${event_id}`).removeClass("blue green");
            $(`#progress_bar_${event_id}`).addClass("green");
          }
        }

    },
    error: function(error) {
      console.log(error);
    }
   });
  })

});