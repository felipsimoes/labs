<?php

class Lock {

	protected $IsLocked;

	public function lock(){

		$this->isLocked = true;
	}

	public function unlock() {

		$this->IsLocked = false;
	}

	public function isLocked(){

		return $this->IsLocked;
	}
}

?>