
<?php

require_once('db/db.php');

class Appointments extends Db {
    //getter and setter
    
    public function checkIfUsernameExists($username) { // checks username to prevent multiple entrys and multiple votes, if not found, will create new user
        $sql = ("SELECT COUNT(*) FROM users WHERE username = ?");
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute([$username]);

        $results = $stmt->fetch();
        $count = $results['COUNT(*)'];

        if($count == 0) {
            $sql = ("INSERT INTO users (username) VALUES (?)");
            $stmt = $this->connect()->prepare($sql);
            $stmt->execute([$username]);
            return true;
        } else {
            return false;
        }
    }
    
    public function getUserID($username) { //returns User ID, needed to assign user to booking/appointment 
        $sql = ("SELECT * FROM users WHERE username = ?");
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute([$username]);

        $results = $stmt->fetch();
        return $results['id'];
    }

    public function getUsername($id) { //returns username by ID, needed to assign user to booking/appointment 
        $sql = ("SELECT username FROM users WHERE id = ?");
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute([$id]);

        $results = $stmt->fetch();
        return $results['username'];
    }

    public function setAppointment($username, $title, $location, $info, $duration, $option1, $option2, $option3, $expires_at) { //insert new Appointment into DB and creates user if not already in db
            $this->checkIfUsernameExists($username);
            $creator_id = $this->getUserID($username);
            $sql = ("INSERT INTO appointments (title, location, info, duration, creator_id, option1, option2, option3, expires_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt = $this->connect()->prepare($sql);
            $stmt->execute([$title, $location, $info, $duration, $creator_id, $option1, $option2, $option3, $expires_at]);
            return true;
    }

    public function getAllAppointments() {
        $sql = ("SELECT a.id,a.title,a.created_at,a.option1,a.option3,a.option2,a.location,a.info,a.duration,a.expires_at,u.username FROM appointments a join users u on a.creator_id = u.id ORDER BY a.id DESC");
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute();

        $results = $stmt->fetchAll();
        return $results;
    }

    public function getAppointmentByID($id) {
        $sql = ("SELECT * FROM appointments WHERE id = $id");
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute();

        $results = $stmt->fetch();
        return $results;
    }

    public function deleteAppointment($id) {
        $sql = ("DELETE FROM appointments WHERE id = $id");
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute();
        return true;
    }
}

$appointment = new Appointments(); //new Object to access Functions in the ServiceHandler