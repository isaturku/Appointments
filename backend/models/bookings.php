
<?php

require_once('db/db.php');

class Bookings extends Db {
    public function getBookingsByAppointmentID($appointment_id) {
        $sql = ("SELECT * FROM bookings b join users u on u.id = b.user_id WHERE b.appointment_id = $appointment_id ORDER BY b.id DESC");
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute();

        $results = $stmt->fetchAll();
        return $results;
    }

    public function setBooking($user_id, $appointment_id, $option_chosen, $comment) {
        $sql = ("INSERT INTO bookings (user_id, appointment_id, option_chosen, comment) VALUES (?, ?, ?, ?)");
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute([$user_id, $appointment_id, $option_chosen, $comment]);
        return true;
    }
}

$bookings = new Bookings(); //new Object to access Functions in the ServiceHandler

