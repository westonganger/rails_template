require("@rails/ujs").start()
require("turbolinks").start()

global.$ = global.jQuery = require('jquery');

// https://github.com/VodkaBears/Vide/issues/183#issuecomment-365603849
jQuery.fn.load = function(callback) { $(window).on("load", callback) };

$(document).ready(function(){
  //$(document).trigger('turbolinks:load');
});

$(document).on('turbolinks:load',  function(){
  $("a[href^='#'], a[href^='/#'], a[href^='tel'], a[href^='mailto']").attr('data-turbolinks','false');

  $('form').prop('autocomplete','off');

  /* Delayed hide on any alert messages */
  var alerts = $(".alert:not(.permanent)")
  setTimeout(function(){
    alerts.fadeOut();
  }, 8000);
});
