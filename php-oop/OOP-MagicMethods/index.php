
<?php 

require 'collections.php';

$c = new Collection();

$c->add('foo');
$c->add('bar');

//$c->baz = 'qux';

echo $c;

// single quotes display exactly what is types
// doesn't concern about variables
echo '<br> Olá $c'; 

// double quotes don't blindly print what is whitin them
// variables are spotted and their values automatically displayed
echo "<br> Olá de novo $c";

//echo $c->baz('one','two','three');

// echo "<pre>".print_r($c->all(),true);

?>