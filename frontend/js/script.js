function loadAppointments() {
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    const json = this.responseText;
    const data = JSON.parse(json);
    document.getElementById("content").innerHTML = "";
    data.forEach((element) => {
      document.getElementById("content").innerHTML += `<div class="termin">
    <h4 class="termin-title">${element.title}</h4>
    <p class="termin-desc">${element.info}</p>
    <p class="termin-date">${new Date(element.created_at).toDateString()}</p>
    <p class="termin-creator">by ${element.username}</p>
    <p class="termin-location">${element.location}</p>
    <div class="termin-actions">
      <button class="action-button delete-button" onclick="deleteAppointment(${
        element.id
      })">
        <span class="material-icons"> delete </span>Delete
      </button>
      <button
        class="action-button"
        data-bs-toggle="modal"
        data-bs-target="#voteModal${element.id}"
        onclick="loadBookings(${element.id})"
      >
        <span class="material-icons" > event </span>Vote
      </button>
    </div>
    <div
      class="modal fade"
      id="voteModal${element.id}"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <form class="booking-form" id="voteForm${element.id}">
        <div class="modal-dialog modal-dialog-scrollable">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Vote</h5>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>
            <div class="modal-body vote-form">
            <div><p>Duration: ${element.duration}</p></div>
              <div class="options">
                <div class="option">
                  <p>${new Date(element.option1).toDateString()}</p>
                  <input type="radio" name="option" value = "${
                    element.option1
                  }"/>
                </div>
                <div class="option">
                  <p>${new Date(element.option2).toDateString()}</p>
                  <input type="radio" name="option" value = "${
                    element.option2
                  }"/>
                </div>
                <div class="option">
                  <p>${new Date(element.option3).toDateString()}</p>
                  <input type="radio" name="option" value = "${
                    element.option3
                  }"/>
                </div>
              </div>
              <label for="username">Username: </label>
              <input type="text" id="username" name="username" />
              <label for="comment">Comment: </label>
              <input type="text" id="comment" name="comment" />
            </div>
            <div id="bookings${element.id}">
            <table>
            <thead><tr><th>User</th><th>Comment</th><th>Option Chosen</th></tr></thead>
            <tbody></tbody>
            </table>
            </div>
            <div class="modal-footer">
              <button
                type="button"
                class="action-button secondary-button"
                data-bs-dismiss="modal"
              >
                Close
              </button>
              <button type="button" onclick="voteSubmit(${
                element.id
              })" class="action-button" data-bs-dismiss="modal" >Vote</button>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>`;
    });
  };
  xhttp.open("POST", "backend/load.allappointments.php");
  xhttp.send();
}
function deleteAppointment(id) {
  const xhttp = new XMLHttpRequest();
  xhttp.onload = loadAppointments;
  fd = new FormData();
  fd.append("delete", id);
  xhttp.open("POST", "backend/appointment.serviceHandler.php");
  xhttp.send(fd);
}
function voteSubmit(id) {
  const xhttp = new XMLHttpRequest();
  xhttp.onload = loadAppointments;
  fd = new FormData();
  const form = document.getElementById(`voteForm${id}`);
  fd.append("username", form.elements["username"].value);
  fd.append("comment", form.elements["comment"].value);
  fd.append("option", form.elements["option"].value);
  fd.append("id", id);
  console.log(form.elements["option"].value);
  xhttp.open("POST", "backend/booking.serviceHandler.php");
  xhttp.send(fd);
}
function newAppointment() {
  const xhttp = new XMLHttpRequest();
  xhttp.onload = loadAppointments;
  fd = new FormData();
  const form = document.getElementById("newAppointment");
  fd.append("username", form.elements["username"].value);
  fd.append("title", form.elements["title"].value);
  fd.append("location", form.elements["location"].value);
  fd.append("info", form.elements["description"].value);
  fd.append("duration", form.elements["duration"].value);
  fd.append("voting1", form.elements["voting1"].value);
  fd.append("voting2", form.elements["voting2"].value);
  fd.append("voting3", form.elements["voting3"].value);
  fd.append("expires-at", form.elements["expires-at"].value);

  xhttp.open("POST", "backend/appointment.serviceHandler.php");
  xhttp.send(fd);
}
function loadBookings(id) {
  const xhttp = new XMLHttpRequest();
  fd = new FormData();
  fd.append("id", id);
  xhttp.onload = function () {
    const bookingsDiv = document.getElementById(`bookings${id}`);
    const data = JSON.parse(this.responseText);
    const table = bookingsDiv.getElementsByTagName("table")[0];
    const tbody = table.getElementsByTagName("tbody")[0];
    tbody.innerHTML = "";
    data.forEach(function (element) {
      const row = tbody.insertRow();
      const user = row.insertCell();
      let text = document.createTextNode(element.username);
      user.appendChild(text);
      const comment = row.insertCell();
      text = document.createTextNode(element.comment);
      comment.appendChild(text);
      const option = row.insertCell();
      text = document.createTextNode(
        new Date(element.option_chosen).toDateString()
      );
      option.appendChild(text);
    });
  };
  xhttp.open("POST", "backend/load.bookings.php");
  xhttp.send(fd);
}
