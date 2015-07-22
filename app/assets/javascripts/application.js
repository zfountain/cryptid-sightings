// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function() {

  // alert("Loading!");

  $.ajax({
    type: "get",
    url: "/cryptids",
    dataType: "json",
    success: function(data, textStatus, jqXHR) {
      console.log(data);
      var cryptids = data;
      for (var i = 0; i < cryptids.length; i++) {
        var cryptid = cryptids[i];
        var cryptidName = cryptid.name;
        var cryptidId = cryptid.id;
        var html = $("<li><a href='/cryptids/" + cryptidId + "'>" + cryptidName + "</a></li>");
          $("#cryptids").prepend(html);
          console.log(cryptidName);
      }
    },
    error: function() {
      alert("There was a problem loading the data!");
    },
    complete: function() {
      // alert("Done Loading!");
    }
  });


  $.ajax({
    type: "get",
    url: "/encounters",
    dataType: "json",
    success: function(data, textStatus, jqXHR) {
      console.log(data);
      var encounters = data;
      for (var i = 0; i < encounters.length; i++) {
        var encounter = encounters[i];
        var encounterTitle = encounter.title;
        var encounterContent = encounter.content;
        var encounterId = encounter.id;
        var html = $("<article><h2>" + encounterTitle + "</h2>" + "<p>" + encounterContent + "</p><a href='/encounters/" + encounterId + "'>Read more</a></article>");
          $("#encounters").prepend(html);
          console.log(encounterTitle);
      }
    },
    error: function() {
      alert("There was a problem loading the data!");
    },
    complete: function() {
      // alert("Done Loading!");
    }
  });
});