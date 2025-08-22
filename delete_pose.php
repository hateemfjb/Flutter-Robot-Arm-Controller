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

$sql = "DELETE FROM robot_status WHERE id = $id";

if ($conn->query($sql) === TRUE) {
    echo "Pose deleted successfully";
} else {
    echo "Error deleting pose: " . $conn->error;
}

$conn->close();
?>