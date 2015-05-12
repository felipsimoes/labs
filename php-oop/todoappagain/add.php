<?php

require_once("init.php");

if(isset($_POST["itemnovo"])){
	
	$item = $_POST["itemnovo"];
	
	$add = $connect->prepare("
			INSERT INTO lista
			VALUES (:nome, 0)"
		);
	$add->execute([
			'nome' => $item
		]);
header("Location: index.php");
}

else{

	echo "Por favor reinsira um valor";
}


?>