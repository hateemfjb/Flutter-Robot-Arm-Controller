<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "robot_arm_db";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id = $_POST['id'];

$sql_reset = "UPDATE robot_status SET run_status = 0";
$conn->query($sql_reset);

$sql_update = "UPDATE robot_status SET run_status = 1 WHERE id = $id";
$conn->query($sql_update);

$conn->close();
?>