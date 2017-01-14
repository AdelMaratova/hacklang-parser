<?php

namespace PhpLang\Phack\PhpParser\Node\Stmt;
use \PhpParser\Node\Name as pName;
use \PhpParser\Node\Stmt as pStmt;

class Alias extends pStmt {
	    use \PhpLang\Phack\PhpParser\Node\GetType;
	
	    /** @var string Alias Name */
	    public $name;
	
	    /** @var string Underlying Alias type */
	    public $type;
	
	    /**
	     * Constructs an Alias node
	     *
	     * @param string $name       Alias name
	     * @param string $type       Aliased type (can be anything)
	     * @param array  $attributes Additional attributes
	     */
	    public function __construct($name, $type, array $values, array $attributes = array()) {
		        $this->name = $name;
		        $this->type = $type;
		        parent::__construct($attributes);
		    }
		
		    public function getSubNodeNames() {
			        return array('name', 'type');
			    }
			}