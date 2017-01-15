<?php

namespace PhpLang\Phack\PhpParser\Node\Expr;
use PhpParser\Node as pNode;

	class Set extends pNode\Expr
	{
			
		/** @var Set[] Items */
		public $items;
	
		/**
		 * Constructs a Set node.
		 *
		 * @param ArrayItem[] $items      Items of the Set
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
	
	