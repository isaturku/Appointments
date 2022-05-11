<?php
require_once("models/appointments.php");

    if(isset($_POST['username'])){ //stores POST variables locally for function call
        $username = $_POST['username'];
        $title = $_POST['title'];
        $location = $_POST['location'];
        $info = $_POST['description'];
        $duration = $_POST['duration'];
        $option1 = $_POST['voting1'];
        $option2 = $_POST['voting2'];
        $option3 = $_POST['voting3'];
        $expires_at = $_POST['expires-at'];
        
        $appointment->setAppointment($username, $title, $location, $info, $duration, $option1, $option2, $option3, $expires_at);
    }

    if(isset($_POST['delete'])){ // deletes Appointment
        $id = $_POST['delete'];
        $appointment->deleteAppointment($id);
    }
?>