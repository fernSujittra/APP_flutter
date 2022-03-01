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

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$id_user = $_GET['id_user'];

		$result = mysqli_query($link, "select s.number_shares as a_num,s.price_shares as a_price,d.price_shares as d_price_shares ,b.total_price_cost,d.profit_sum,d.sum_dividend 
                                        from share s 
                                        left join dividend d on s.id_user=d.id_user 
                                        left join booking b on s.id_user=b.id_user 
                                        where s.Id_user='$id_user';");

		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} else echo "Welcome Master UNG";	// if2
   
}	// if1


	mysqli_close($link);
?>