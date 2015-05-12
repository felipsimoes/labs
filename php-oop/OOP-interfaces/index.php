<?php 

require_once "TalkInterface.php";
require_once "cat.php";
require_once "dog.php";

$dog = new Dog();
$cat = new Cat();

echo $dog->talk() . "<br>". $cat->talk();

?>