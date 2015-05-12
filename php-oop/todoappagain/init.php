<?php
try{
$connect = new PDO("mysql:dbname=todo;host=localhost", "root","root");
}
catch(PDOException $erro){
	echo $erro;
}

?>