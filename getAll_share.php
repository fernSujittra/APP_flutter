<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

	$result = mysqli_query($link, "SELECT concat(u.fname,'    ',u.lname) as fullname,a.number_shares,d.sum_dividend
                                                        FROM `share` a
                                                        inner join user u on a.id_user = u.Id_user
                                                        inner join dividend d on a.id_user=d.id_user and a.id_share=d.id_share
                                                        order by a.id_user asc;");
   
	while($row=mysqli_fetch_assoc($result)){
	$output[]=$row;
	}

	echo json_encode($output);

	mysqli_close($link);
?>