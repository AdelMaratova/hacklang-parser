<?php

namespace PhpLang\Phack\PhpParser\Node\Expr;
use \PhpParser\Node as pNode;

class Pair extends pNode\Expr

{
	/** @var null|Expr Key */
	public $item1;
	/** @var Type */
	public $item2;


	/**
	 * Constructs a pair node.
	 *
	 * @param Expr      $item1      1st item
	 * @param Expr 		$item1      2nd item
	 * @param array     $attributes Additional attributes
	 */
	public function __construct($item1, $item2,  array $attributes = array()) {
		parent::__construct($attributes);
		$this->item1 = $item1;
		$this->item2 = $item2;
	
	}

	public function getSubNodeNames() {
		return array('key', 'type');
	}
}
