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
		$username = $_GET['username'];
		$password = $_GET['password'];
		$fname = $_GET['fname'];
		$lname = $_GET['lname'];
		$card_id =$_GET['card_id'];
		$birth_date = $_GET['birth_date'];
		$age = $_GET['age'];
		$sex = $_GET['sex'];
		$phone = $_GET['phone'];
		$career = $_GET['career'];
		$earnings = $_GET['earnings'];
		$Investment = $_GET['Investment'];

		$home_number = $_GET['home_number'];
		$home = $_GET['home'];
		$road = $_GET['road'];
		$alley = $_GET['alley'];
		$tombon_name = $_GET['tombon_name'];
		$aumphur_name = $_GET['aumphur_name'];
		$province_name = $_GET['province_name'];
		$post_code = $_GET['post_code'];
							
		$sql = "UPDATE `user` SET `username` = '$username', `password` = '$password', `fname` = '$fname', `lname` = '$lname', `card_id` = '$card_id', `birth_date` = '$birth_date'
								, `age` = '$age' , `sex` = '$sex', `phone` = '$phone', `career` = '$career', `earnings` = '$earnings', `Investment` = '$Investment' WHERE Id_user = '$id_user';";

		$result = mysqli_query($link, $sql);

		$sql2="UPDATE `address` SET `home_number` = '$home_number', `home` = '$home', `road` = '$road', `alley` = '$alley' , `tombon_name` = '$tombon_name' , `aumphur_name` = '$aumphur_name' 
					, `province_name` = '$province_name' , `post_code` = '$post_code' WHERE Id_user = '$id_user';";
		$result2 = mysqli_query($link, $sql2);

//echo $sql;
		if ($result2) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}

	mysqli_close($link);
?>