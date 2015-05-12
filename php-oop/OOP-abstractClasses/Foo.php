<?php


//this is an abstract class, therefore it cannot be 
//instantiated
abstract class Foo {

	public function bar(){

		return 'foobar';
	}

	abstract public function foobar();
}

?>