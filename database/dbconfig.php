<?php
    $host = "127.0.0.1";
    $username = "root";
    $password = "";
    $dbname ="roi_et_swine";

    try{
        $conn = new PDO("mysql:host=$host;dbname=$dbname",$username,$password);
        $conn->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
    }catch(PDOException $e){
        echo "Connection failed:".$e->getMessage();
        exit();
    }
?>