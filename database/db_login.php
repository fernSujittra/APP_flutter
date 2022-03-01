<?php

    require_once "dbconfig.php";

   

    $param = array(
        'username' => $_GET['u']
    );
    $sql = "SELECT username,password,id_role FROM login where username= :username ";
    $statement = $conn->prepare($sql);
    $statement->execute($param);

    /*$sql = "SELECT username,password,id_role FROM login ";
    $statement = $conn->query($sql);
    $statement->execute();*/

    $result = $statement->fetchAll(PDO::FETCH_ASSOC);
    print_r(json_encode($result));
    /*if(count($result)){
        $response = array(
                'status' => true,
                'response' =>$result
        )
        return json_encode($response);
    }else{

    }*/
?>