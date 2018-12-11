const adminForm = document.getElementById("adminContent");

adminForm.onsubmit = function(e) {
  e.preventDefault();

  let data = {};
  let formdata = new FormData(adminForm);
  for (let tuple of formdata.entries()) {
    data[tuple[0]] = tuple[1];
  }

  var xhr = new XMLHttpRequest();
  xhr.open(adminForm.method, adminForm.action, true);
  xhr.setRequestHeader("Content-Type", "application/json; charset=UTF-8");

  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      document.getElementById("result").innerHTML = "Content updated";
    }
    if (xhr.readyState === 4 && xhr.status === 500) {
      document.getElementById("result").innerHTML = "ERROR";
    }
  };

  xhr.send(JSON.stringify({ homePage: data }));
};
