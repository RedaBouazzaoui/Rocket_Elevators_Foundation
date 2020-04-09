
/*******************	INTERVENTION FORM ***********************/
var _hash = window.location.hash;

//-------------------------------------------------------------------------
$(".building-class, .battery-class, .column-class, .elevator-class").hide();

// Show and hide buildings for customer X
$("#building").prop("disabled", true); // second dropdown is disabled while first dropdown is empty

$("#customer").change(function() {
  var customer = $(this).val();
  if (customer == "") {
    $("#building").prop("disabled", true);
  } else {
    $("#building").prop("disabled", false);
  }
  $.ajax({
    url: "/interventions/get_building",
    method: "GET",
    dataType: "json",
    data: { customer: customer },
    error: function(xhr, status, error) {
      console.error("AJAX Error: " + status + error);
    },
    success: function(response) {
      console.log(response);
      var buildings = response["buildings"];
      $("#building").empty();
      $("#battery").empty();
      $("#column").empty();
      $("#elevator").empty();

      $("#building").append("<option>Select Building</option>");
      $("#battery").append("<option>Select Battery</option>");
      $("#column").append("<option>-None-</option>");
      $("#elevator").append("<option>-None-</option>");

      for (var i = 0; i < buildings.length; i++) {
        $("#building").append(
          '<option value="' +
            buildings[i]["id"] +
            '">' +
            buildings[i]["customer_id"] +
            "</option>"
        );
      }
    }
  });
});

// Show and hide batteries for building X
$("#building").change(function() {
  var building = $(this).val();
  if (building == "") {
    $("#battery").prop("disabled", true);
  } else {
    $("#battery").prop("disabled", false);
  }
  $.ajax({
    url: "/interventions/get_battery",
    method: "GET",
    dataType: "json",
    data: { building: building },
    error: function(xhr, status, error) {
      console.error("AJAX Error: " + status + error);
    },
    success: function(response) {
      var batteries = response["batteries"];
      $("#battery").empty();

      $("#battery").append("<option>Select Battery</option>");
      for (var i = 0; i < batteries.length; i++) {
        $("#battery").append(
          '<option value="' +
            batteries[i]["id"] +
            '">' +
            batteries[i]["building_id"] +
            "</option>"
        );
      }
    }
  });
});

// Show and hide columns for battery X
$("#battery").change(function() {
  var battery = $(this).val();
  if (battery == "") {
    $("#column").prop("disabled", true);
  } else {
    $("#column").prop("disabled", false);
  }
  $.ajax({
    url: "/interventions/get_column",
    method: "GET",
    dataType: "json",
    data: { battery: battery },
    error: function(xhr, status, error) {
      console.error("AJAX Error: " + status + error);
    },
    success: function(response) {
      var columns = response["columns"];
      $("#column").empty();

      $("#column").append("<option>-None-</option>");
      for (var i = 0; i < columns.length; i++) {
        $("#column").append(
          '<option value="' +
            columns[i]["id"] +
            '">' +
            columns[i]["battery_id"] +
            "</option>"
        );
      }
    }
  });
});

// Show and hide elevators for column X
$("#column").change(function() {
  var column = $(this).val();
  if (column == "") {
    $("#elevator").prop("disabled", true);
  } else {
    $("#elevator").prop("disabled", false);
  }
  $.ajax({
    url: "/interventions/get_elevator",
    method: "GET",
    dataType: "json",
    data: { column: column },
    error: function(xhr, status, error) {
      console.error("AJAX Error: " + status + error);
    },
    success: function(response) {
      var elevators = response["elevators"];
      $("#elevator").empty();

      $("#elevator").append("<option>-None-</option>");
      for (var i = 0; i < elevators.length; i++) {
        $("#elevator").append(
          '<option value="' +
            elevators[i]["id"] +
            '">' +
            elevators[i]["id"] +
            "</option>"
        );
      }
    }
  });
});
// Customer drop down menu
$(document).ready(function() {
  var choice = document.getElementById("customer");
  choice.addEventListener("change", customer);
  choice.addEventListener("change", clear);
});

var customer = function() {
  var choice = document.getElementById("customer").value;
  if (choice != 0) {
    $(".building-class").show();
  }
};

// Building drop down menu
$(document).ready(function() {
  var choice = document.getElementById("building");
  choice.addEventListener("change", building);
  choice.addEventListener("change", clear);
});

var building = function() {
  var choice = document.getElementById("building").value;
  if (choice != 0) {
    $(".battery-class").show();
  }
};

// Battery drop down menu
$(document).ready(function() {
  var choice = document.getElementById("battery");
  choice.addEventListener("change", battery);
  choice.addEventListener("change", clear);
});

var battery = function() {
  var choice = document.getElementById("battery").value;
  if (choice != 0) {
    $(".column-class").show();
  }
};

// Column drop down menu
$(document).ready(function() {
  var choice = document.getElementById("column");
  choice.addEventListener("change", column);
  choice.addEventListener("change", clear);
});

var column = function() {
  var choice = document.getElementById("column").value;
  if (choice != 0) {
    $(".elevator-class").show();
  }
};

// Function that reset all inputs and prices-----------------------------------------------------
var clear = function() {
  $(".form-control-1, .form-control-2, .form-control-3, .form-control-4").each(
    function() {
      $(this).val("");
    }
  );
};

/**
	BROWSER HASH - from php/contact.php redirect!
	#alert_success 		= email sent
	#alert_failed		= email not sent - internal server error (404 error or SMTP problem)
	#alert_mandatory	= email not sent - required fields empty
**/ jQuery(
  _hash
).show();