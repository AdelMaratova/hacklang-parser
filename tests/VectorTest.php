<?php

require __DIR__ . '/../vendor/autoload.php';

use PhpLang\Phack\Test;
use PhpParser\Node\Stmt\Echo_;
use PhpParser\Node\Scalar\String_;

class VectorTest extends PHPUnit_Framework_TestCase {
	    use Test\AssertParseTrait;
	
	    public function testVector() {
				$this->assertParse (
				'Array
(
    [0] => PhpParser\Node\Stmt\Function_ Object
        (
            [byRef] => 
            [name] => f
            [params] => Array
                (
                )

            [returnType] => PhpLang\Phack\PhpParser\Node\GenericsType Object
                (
                    [basetype] => Vector
                    [subtypes] => Array
                        (
                            [0] => int
                        )

                    [attributes:protected] => Array
                        (
                            [startLine] => 1
                            [endLine] => 1
                        )

                )

            [stmts] => Array
                (
                    [0] => PhpParser\Node\Stmt\Return_ Object
                        (
                            [expr] => PhpLang\Phack\PhpParser\Node\Expr\Vector Object
                                (
                                    [items] => Array
                                        (
                                            [0] => PhpParser\Node\Scalar\LNumber Object
                                                (
                                                    [value] => 1
                                                    [attributes:protected] => Array
                                                        (
                                                            [startLine] => 1
                                                            [endLine] => 1
                                                            [kind] => 10
                                                        )

                                                )

                                            [1] => PhpParser\Node\Scalar\LNumber Object
                                                (
                                                    [value] => 2
                                                    [attributes:protected] => Array
                                                        (
                                                            [startLine] => 1
                                                            [endLine] => 1
                                                            [kind] => 10
                                                        )

                                                )

                                            [2] => PhpParser\Node\Scalar\LNumber Object
                                                (
                                                    [value] => 3
                                                    [attributes:protected] => Array
                                                        (
                                                            [startLine] => 1
                                                            [endLine] => 1
                                                            [kind] => 10
                                                        )

                                                )

                                        )

                                    [attributes:protected] => Array
                                        (
                                        )

                                )

                            [attributes:protected] => Array
                                (
                                    [startLine] => 1
                                    [endLine] => 1
                                )

                        )

                )

            [attributes:protected] => Array
                (
                    [startLine] => 1
                    [endLine] => 1
                )

        )

)
',
								'function f () : Vector <int>{return Vector {1,2,3};}' );
			}
		}
