<?php 

session_start();

$_SESSION['user_id'] = 1;

$db = new PDO('mysql:dbname=todoapp;host=localhost', 'root', 'root');

// Handle this in some other way
if(!isset($_SESSION['user_id'])) {
    die('You are not signed in.');
}

?>