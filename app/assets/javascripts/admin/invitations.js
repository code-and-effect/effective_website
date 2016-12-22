$(document).on('click', '[data-strip-whitespace]', function(event) {
  event.preventDefault();

  var $obj = $(event.currentTarget).closest('.form-group').find('textarea');
  if ($obj.length > 0) {
    $obj.val($.trim($obj.val().replace(/  /g, '')));
  }
});
