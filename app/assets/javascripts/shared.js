//= require jquery
//= require rails-ujs
//= require on_the_spot
//
// require activestorage
// require actiontext
// require actioncable
//
//= require turbolinks

// https://github.com/VodkaBears/Vide/issues/183#issuecomment-365603849
jQuery.fn.load = function(callback) { $(window).on("load", callback) };

/*
$(document).ready(function(){
  $(document).trigger('turbolinks:load');
});
*/

$(document).on('turbolinks:load',  function(){
  $("a[href^='#'], a[href^='/#'], a[href^='tel'], a[href^='mailto']").attr('data-turbolinks','false');

  $('form').prop('autocomplete','off').attr('novalidate', true);
});

$(document).on("click", "a.slow, button.slow", function(){
  $("#loader").show();
});

$(document).on('submit', "form[enctype='multipart/form-data'], form.slow", function(){
  $("#loader").show();
});

/* Disabled because Turbolinks is so fast it doesnt require a loader */
/*
$(window).on('beforeunload', function(){
  if(!window.skipLoader){
    $('#loader').show();
  }
});
*/

$(document).on('input', 'input.is-invalid, textarea.is-invalid', function(e){
  $(this).removeClass('is-invalid');
  $(this).closest('.form-group').removeClass('form-group-invalid').find('.invalid-feedback').remove();
});

/* If an input field has a pattern attribute, we expect it to contain a regular expression */
/* After a key is pressed, if the whole field does not match the regexp then we reject the last input key */
$(document).on('keydown', 'input[pattern]', function(e){
  var input = $(this);
  var oldVal = input.val();
  var regex = new RegExp(input.attr('pattern'), 'g');

  setTimeout(function(){
    var newVal = input.val();
    if(!regex.test(newVal)){
      input.val(oldVal); 
    }
  }, 0);
});

/* If a number input field has a maxlength attribute we limit the length of the input to the specified number of characters */
$(document).on('keydown', 'input[type=number][maxlength]', function(e){
  var input = $(this);
  var oldVal = input.val();
  var maxlength = Number(input.attr('maxlength'));

  setTimeout(function(){
    var newVal = input.val();
    if(newVal.length > maxlength){
      input.val(oldVal); 
    }
  }, 0);
});

window.getParam = function(name, url) {
  if (!url) url = window.location.href;
  name = name.replace(/[\[\]]/g, '\\$&');
  var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
      results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, ' '));
}
