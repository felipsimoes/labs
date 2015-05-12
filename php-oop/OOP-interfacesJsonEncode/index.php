
<?php 

require 'collections.php';

$c = new Collection();

$c->add('foo');
$c->add('bar');

$c->baz = 'qux';

echo json_encode($c);

?>