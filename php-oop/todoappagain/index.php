<?php

require_once("init.php");

$itemsQuery = $connect->prepare("
	SELECT * FROM lista
	");
$itemsQuery->execute();

$items = $itemsQuery->rowCount() ? $itemsQuery : [];

?>

<!DOCTYPE>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style.css">
	<script src="jquery-1.8.3.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="script.js">	</script>    
</head>
<body>
	<div id="container">
		<h1>TO DO APP</h1>
		<div id="display">
		<?php if(!empty($items)): ?>
			<ul id="list">
				<?php foreach ($items as $item): ?>
					<li><?php echo $item['nome']; ?></li>
				<?php endforeach;?>
			</ul>
		<?php endif;?>
		</div>
		<form id="form" method="post" action="#">
			<input type="text" name="itemnovo" id="input_field">
		</form>
	</div>
</body>
</html>