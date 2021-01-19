$(document).ready(function () {
  $("tbody").click(function (event) {
    var target = $(event.target);
    var element = target.parent().parent().children(".info");
    if (element.is(":hidden"))
      element.show();
    else 
      element.hide();
  });
});
