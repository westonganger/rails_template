//= require shared
//= require active_admin/base
//= require activeadmin_addons/all
//= require vendor/jquery.formatCurrency.min

$(document).on('turbolinks:load', function(){

  $('input.money').formatCurrency();

  /* Delayed hide on any alert messages */
  var alerts = $(".flash:not(.permanent)");
  setTimeout(function(){
    alerts.fadeOut();
  }, 8000);

  $('.table_tools').append(
    "<button class='show-filters' style='float:right;' type='button'>Show Search Filters</button>"
  );

  $('#filters_sidebar_section').prepend(
    "<button class='show-filters' style='float:right;' type='button'>Hide/Cancel</button>"
  );

});

$(document).on("click", "button.show-filters", function(){
  $("#sidebar")[0].click();
});

/* ARCTIC ADMIN JS BELOW */
$(document).on('click touchstart', '#sidebar', function(e) {
  var animationDuration = 450;

  var position = $(this).position();
  var width = $(this).width();
  var target = e.target;
  if ((e.pageX < position.left) && (target.tagName != 'SELECT') && (target.tagName != 'OPTION')) {
    if ($(this).css('right') == '0px') {
      $(this).css('position', 'fixed');
      $(this).animate({
        right: "-="+width
      }, animationDuration, function() {
        $(this).removeAttr('style');
        animationFilterDone = true;
      });
    } else {
      $(this).animate({
        right: "+="+width
      }, animationDuration, function() {
        $(this).css('position', 'absolute');
        animationFilterDone = true;
      });

      $('html, body').animate({scrollTop: 0}, {duration: animationDuration, easing: ''});
    }
  }
});

var animationDone = true;
$(document).on('click touchstart', '#utility_nav', function(e) {
  var position = $(this).position();
  var tabs = $('#tabs');
  var width = Math.round(tabs[0].getBoundingClientRect().width);

  if (e.pageX < (position.left + 40)) {
    if(animationDone == true) {
      animationDone = false;
      if (tabs.css('left') == '0px') {
        tabs.animate({
          left: "-="+width
        }, 400, function() {
          animationDone = true;
        });
      } else {
        tabs.animate({
          left: "+="+width
        }, 400, function() {
          animationDone = true;
        });
      }
    }
  }
});

$(document).on('click touchstart', 'body', function(e) {
  var tabs = $('#tabs');
  var width = Math.round(tabs[0].getBoundingClientRect().width);
  if (tabs.css('left') == '0px') {
    if (e.pageX > width && e.pageY > 60) {
      if(animationDone == true) {
        animationDone = false;
        tabs.animate({
          left: "-="+width
        }, 400, function() {
          animationDone = true;
        });
      }
    }
  }
});

$(document).on('click', '#tabs .has_nested', function(e) {
  e.stopPropagation();
  $(this).toggleClass('open');
});
