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
//= require jquery-ui/jquery-ui
//= require ckeditor-jquery
//= require jcrop/js/Jcrop
//= require knockout
//= require bootstrap/dist/js/bootstrap
//= require metisMenu/dist/metisMenu
//= require raphael/raphael
//= require morrisjs/morris
//= require datatables/media/js/jquery.dataTables
//= require datatables-plugins/integration/bootstrap/3/dataTables.bootstrap
//= require startbootstrap-sb-admin-2/dist/js/sb-admin-2
//= require quill


//= require_tree .

/* global $ */
$.fn.dataTable.ext.search.push(
  function(setting, data, dataIndex) {
    var isPaid = $("#filter-is-paid").get(0).checked;
    var isFree = $("#filter-is-free").get(0).checked;
    var flocation = $("#filter-location").val().toLowerCase();
    var returnFlag = true;
    if (isPaid && isFree) {
      // No filter
      returnFlag = returnFlag && true;
    } else if (!isPaid && !isFree) {
      // Match nothing
      return false;
    } else if (!isPaid && isFree) {
      // Exclude paid
      returnFlag = returnFlag && data[0].indexOf("Charter Czar") == -1;
    } else if (isPaid && !isFree) {
      // Exclude free
      returnFlag = returnFlag && data[0].indexOf("Charter Czar") != -1;
    }
    if (flocation != "" && data[2].toLowerCase().indexOf(flocation) == -1) {
      // Reject no matching location
      returnFlag = false;
    }
    return returnFlag;
  }
);

$(document).ready(function() {
  var $dtable = $('.datatable').DataTable();
  $("#filter-is-paid, #filter-is-free, #filter-location").on("change", function(e){
    $dtable.draw();
  });
  $("#filter-location").on("keyup", function(e){
    $dtable.draw();
  })
});
