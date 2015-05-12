<?php

require("chest.php");
require("lock.php");

$Chest = new Chest(new Lock);

$Chest->close();

?>