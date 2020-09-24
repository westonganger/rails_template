$(document).on('turbolinks:load',  function(){
  //$('[data-toggle="popover"]').popover();

  //$('[data-toggle="tooltip"]').tooltip();
});

/* Bootstrap AJAX Modals */
var active_modal = null;
$(document).on('click','a[data-toggle=ajax_modal]', function(e) {
  e.preventDefault();
  //$('body').modalmanager('loading');
  $('#loader').addClass('withmodal').show();
  if (active_modal) {
    active_modal.modal('hide');
    active_modal = null;
  }
  var target = $(this).attr('data-target');
  var width = $(this).attr('data-width');

  var url = $(this).attr('href');
  if ($(target).length > 0) {
    $(target).remove();
  }
  var $modal = $('<div/>', {
    id: target.split("#").join(""),
    // 'class': 'modal hide fade',
    'class': 'modal hide',
    data: {width: width, backdrop: 'static'}
  }).appendTo('body');;
  $modal.load(url, function(){
    $modal.modal('show');
    $('#loader').removeClass('withmodal').hide();
  });
  active_modal = $modal;
});

$('body').on('hide', '.modal', function(){
  active_modal = null;
});

$('a[data-toggle=modal]').on('click', function(e){
  var target = $(this).attr('data-target');
  var url = $(this).attr('href');
  $(target).load(url);
});
/* END bootstrap AJAX modals */
