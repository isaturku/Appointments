<?php

include_once('models/appointments.php');

$allAppointments = $appointment->getAllAppointments();
echo json_encode($allAppointments);
