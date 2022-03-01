<?php

    require_once "dbconfig.php";

   


    $sql = "SELECT concat(a.fname,' ',a.lname) as name,s.number_shares,d.sum_dividend
    FROM user a
    inner join share s on a.Id_user = s.id_user
    inner join dividend d on s.id_user=d.id_user;";
        $statement = $conn->query($sql);
    $statement->execute();

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