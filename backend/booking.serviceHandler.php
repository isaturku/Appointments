<?php
require_once("models/bookings.php");
require_once("models/appointments.php");

    $appointment_id = $_POST['id']; //stores POST variables locally for function call
    $username = $_POST['username'];
    $comment = $_POST['comment'];
    $option = $_POST['option'];
    
    $appointment->checkIfUsernameExists($username); //if the username doesn't exist, it creates a new user to get an ID in the next line
    $user_id = $appointment->getUserID($username);
    $bookings->setBooking($user_id, $appointment_id, $option, $comment);
    