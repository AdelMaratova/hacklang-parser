<?php

namespace PhpLang\Phack\PhpParser\Node\Expr;
use \PhpParser\Node as pNode;

class MapItem extends pNode\Expr

{
	/** @var Expr Key */
	public $key;
	/** @var Expr value */
	public $value;


	/**
	 * Constructs an array item node.
	 *
	 * @param Expr     	$key      	Key
	 * @param Expr 		$value      value
	 * @param array     $attributes Additional attributes
	 */
	public function __construct($key, $value, array $attributes = array()) {
		parent::__construct($attributes);
		$this->key = $key;
		$this->value = $value;
	
	}

	public function getSubNodeNames() {
		return array('key', 'value');
	}
}
