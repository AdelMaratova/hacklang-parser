<?php

namespace PhpLang\Phack\PhpParser\Node\Expr;
use PhpParser\Node as pNode;

	class ImmVector extends pNode\Expr
	{
			
		/** @var ImmSet[] Items */
		public $items;
	
		/**
		 * Constructs an immutable set node.
		 *
		 * @param ArrayItem[] $items      Items of the set
		 * @param array       $attributes Additional attributes
		 */
		public function __construct(array $items = array(), array $attributes = array()) {
			parent::__construct($attributes);
			$this->items = $items;
		}
	
		public function getSubNodeNames() {
			return array('items');
		}
	
	}
	
	