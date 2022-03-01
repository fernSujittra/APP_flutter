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
				
		$username = $_GET['username'];
		$password = $_GET['password'];
		$fname = $_GET['fname'];
        $lname = $_GET['lname'];
		$citizen = $_GET['citizen'];
		$birthdate = $_GET['birthdate'];
		$age = $_GET['age'];
		$sex = $_GET['sex'];
		$phone = $_GET['phone'];
		$career = $_GET['career'];
		$income = $_GET['income'];
		$invest = $_GET['invest'];

		$homenum = $_GET['homenum'];
		$homename = $_GET['homename'];

		$hroad = $_GET['homeroad'];
		$homesoi = $_GET['homesoi'];
		$hometumbol = $_GET['hometumbol'];
		$homeamphur = $_GET['homeamphur'];
		$homeprovince = $_GET['homeprovince'];
		$homecode = $_GET['homecode'];
							
		$sql = "INSERT INTO `user`(`Id_role`, `username`, `password`, `fname`, `lname`, `card_id`, `birth_date`, `age`, `sex`, `phone`, `career`, `earnings`, `Investment`) VALUES ('3','$username','$password','$fname','$lname','$citizen','$birthdate','$age','$sex','$phone','$career','$income','$invest')";
		$result1 = mysqli_query($link, $sql);

		$sql2= "INSERT INTO `address`(`home_number`, `home`, `road`, `alley`, `tombon_name`, `aumphur_name`, `province_name`, `post_code`) VALUES ('$homenum','$homename','$hroad','$homesoi','$hometumbol','$homeamphur','$homeprovince','$homecode');";
		$result2 = mysqli_query($link, $sql2);
			//echo $sql;
		if ($result2) {
			//echo $result;
			$id_user ='';
			$sql3 = "SELECT Id_user FROM `user` where card_id='$citizen' ";
			$result3 = $link -> query($sql3);
			$row = $result3 -> fetch_array(MYSQLI_ASSOC);
			$id_user = $row["Id_user"];
			//echo "test".$id_user;
			
			$sql_address = "UPDATE `address` set Id_user='$id_user' where Id_user is null";
			$result3 = mysqli_query($link, $sql_address);
			//echo $sql_address;
			if ($result3) {
				echo "true";
			}else{
				echo "false";
			}
		
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>