$(document).ready(function() {
  $("#users-search #term").on("keyup", function() {
    $.get(
      $("#users-search").attr("action"),
      {
        term: $("#users-search #term").val()
      },
      function() {
        const result = $("#users-result").html();

        if (!result) {
          $("#users-search #term").popover({
            content: "No user found.",
            placement: "bottom",
            html: true,
            trigger: "focus"
          });
        } else {
          $("#users-search #term").popover({
            content: $("#users-result"),
            placement: "bottom",
            html: true,
            trigger: "focus"
          });
        }
        $("#users-search #term").popover("show");
      }
    );
  });
});
