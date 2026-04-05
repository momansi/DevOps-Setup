<?php
$servername = "db";
$username = "root";
$password = "rootpass";
$dbname = "testdb";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

echo "<h1>Connected to MySQL successfully!</h1>";
?>