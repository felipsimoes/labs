<?php

require_once 'init.php';

$itemsQuery = $db->prepare("
    SELECT id, name, done
    FROM items
    WHERE user = :user
");

$itemsQuery->execute([
    'user' => $_SESSION['user_id']
]);

$items = $itemsQuery->rowCount() ? $itemsQuery : [];

/* foreach ($items as $item) {
    echo $item['name'], '<br>';
} */
?>
<!DOCTYPE>
<html lang="pt-br">
<head>
	<meta charset="UTF-8">
	<title>TO DO App</title>
	<link rel="stylesheet" type="text/css" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>


<body>
    <div class="list">
        <h1 class="header">To do.</h1>
    <?php if(!empty($items)): ?>
        <ul class="items">
        <?php foreach ($items as $item): ?>
            <li><span class="item<?php echo $item['done']  ? ' done' : '' ?>"><?php echo $item['name'];?></span>
            <?php if(!$item['done']):?>
                <a href="mark.php?as=done&item=<?php echo $item['id']?>" class="done-button">Mark as done</a>
            <?php endif;?>
            </li>
        <?php endforeach;?> 
        </ul>
    <?php else: ?>
        <p>You haven't added any items yet.</p>
    <?php endif;?>
        
        <form class="item-add" action="add.php" method="post" onsubmit="return validation();">
            <input type="text" name="name" id="input_name"placeholder="Type a new item here." class="input" autocomplete="off" required>
            <input type="submit" value="add" class="submit">
        </form>
    </div>
    <script type="text/javascript">
        function validation(){
            var name = document.getElementById('input_name').value;

            if(name==" "){
                alert("Please fill with a new item");
                return false;
            }
            else {
                return true;
            }

        }
    </script>
</body>
</html>