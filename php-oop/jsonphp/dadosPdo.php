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

//if this query returns a rowCount then...
if($query->rowCount()) {
	//all the results from that query are turn into an object called r
	while($r = $query->fetch(PDO::FETCH_OBJ)){
		//all values for the property nome of the object called r
		//will then be shown at each iteration
		echo $r->nome ,"<br/>";
	}
}
else {
	echo "No results"; 
}


?>