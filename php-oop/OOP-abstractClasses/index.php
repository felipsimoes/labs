<?php

require 'Foo.php';
require 'Bar.php';

//class Foo can't be instantiated because it is abstract
//class Bar extends the abstract class Foo
//through the object $bar the method bar() can be called
$bar = new Bar();

echo $bar->bar() . '<br>';
echo $bar->baz() . '<br>';
echo $bar->foobar();

?>