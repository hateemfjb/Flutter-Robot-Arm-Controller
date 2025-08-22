<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "robot_arm_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$motor1 = $_POST['motor1'];
$motor2 = $_POST['motor2'];
$motor3 = $_POST['motor3'];
$motor4 = $_POST['motor4'];

$sql = "INSERT INTO robot_status (motor1, motor2, motor3, motor4, run_status) 
        VALUES ($motor1, $motor2, $motor3, $motor4, 0)";

if ($conn->query($sql) === TRUE) {
    echo "Pose saved successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>ّ