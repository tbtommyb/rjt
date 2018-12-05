const adminForm = document.getElementById("adminContent");

adminForm.onsubmit = function(e) {
  // stop the regular form submission
  e.preventDefault();

  let data = {};
  let formdata = new FormData(adminForm);
  for (let tuple of formdata.entries()) {
    data[tuple[0]] = tuple[1];
  }

  var xhr = new XMLHttpRequest();
  xhr.open(adminForm.method, adminForm.action, true);
  xhr.setRequestHeader("Content-Type", "application/json; charset=UTF-8");

  xhr.send(JSON.stringify({ homePage: data }));

  xhr.onloadend = function() {
    document.getElementById("result").innerHTML = "Content updated";
  };
  xhr.onerror = function() {
    document.getElementById("result").innerHTML = "ERROR";
  };
};
