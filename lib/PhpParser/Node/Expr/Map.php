<?php

namespace PhpLang\Phack\PhpParser\Node\Expr;
use PhpParser\Node as pNode;

	class Map extends pNode\Expr
	{
			
		/** @var Map[] Items */
		public $items;
	
		/**
		 * Constructs a map node.
		 *
		 * @param MapItem[] $items      Items of the map
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
	
	