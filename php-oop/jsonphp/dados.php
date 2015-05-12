<?php

/*
Connect to database mysql
*/
try {
$dbconn = new PDO("mysql:host=localhost;dbname=labjscript","root","root");

}
catch(PDOException $erro){
    echo $erro->getMessage();
    die();
}
//make a property to the dbconn class called query
$query = $dbconn->query("SELECT * FROM livros");
$nresult = $query->rowCount();
//if this query returns a rowCount then...
if($nresult > 0) {
	$results = $query->fetchAll();

 	//print_r($results);

 	echo json_encode($results, JSON_PRETTY_PRINT);
}
else {
	echo "No results"; 
}


?>