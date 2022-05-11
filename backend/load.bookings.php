<?php
require_once("models/bookings.php");
require_once('models/appointments.php');

$id = $_POST['id'];
$allBookings = $bookings->getBookingsByAppointmentID($id);
echo json_encode($allBookings);
