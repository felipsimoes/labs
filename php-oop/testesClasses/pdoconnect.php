<?php

try{

//Conecta ao banco
$dbconnection = new PDO("mysql:host=localhost;port=3306;dbname=todoapp","root","root");

//variavel armazena resultado da query 
$searchquery = $dbconnection->query("SELECT * FROM items");

//se retornar algo da query
if($searchquery){
	foreach($searchquery as $searchresult){
		//exibe o resultado
		echo $searchresult['name']."<br/>";
	}

}

//Encerra conexao
$dbconnection = null;

}
catch(PDOException $error){
	//Em caso de erro exibe
	echo "Erro: <code>" . $error->getMessage() . "</code>";
}

?>