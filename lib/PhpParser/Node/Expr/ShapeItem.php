<?php

namespace PhpLang\Phack\PhpParser\Node\Expr;
use \PhpParser\Node as pNode;

class ShapeItem extends pNode\Expr

{
	/** @var null|Expr Key */
	public $key;
	/** @var Type */
	public $type;


	/**
	 * Constructs an array item node.
	 *
	 * @param Type     $type      Type
	 * @param null|Expr $key        Key
	 * @param array     $attributes Additional attributes
	 */
	public function __construct( $key, $type,  array $attributes = array()) {
		parent::__construct($attributes);
		$this->key = $key;
		$this->type = $type;
	
	}

	public function getSubNodeNames() {
		return array('key', 'type');
	}
}
