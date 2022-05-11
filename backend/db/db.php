<?php
class Db { //Datenbankanbindung über PDO
    private $host = 'localhost';
    private $user = 'bif2webscriptinguser';
    private $password = 'bif2021';
    private $dbname = 'websc_db';

    protected function connect() { //SQL Fehler werden hier abgefangen und lesbar ausgegeben, die connect-Methode wird in allen anderen Methoden verwendet
        try{
            $dsn = 'mysql:host=' . $this->host . ';dbname='. $this->dbname;
            $pdo = new PDO($dsn, $this->user, $this->password);
            $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE,PDO::FETCH_ASSOC);
            $pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);

            return $pdo;
        } catch (PDOException $e) {
            echo "SQL Error: ". $e->getMessage();
        }
    }
}
?>