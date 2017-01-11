<?php

require __DIR__ . '/../vendor/autoload.php';

use PhpLang\Phack\Test;
use PhpParser\Node\Stmt\Echo_;
use PhpParser\Node\Scalar\String_;

class PhackAliasTest extends PHPUnit_Framework_TestCase {
	    use Test\AssertParseTrait;
	
	    public function testParseHelloWorld() {
				$this->assertParse (
				'Array
(
    [0] => PhpParser\Node\Stmt\Echo_ Object
        (
            [exprs] => Array
                (
                    [0] => PhpParser\Node\Scalar\String_ Object
                        (
                            [value] => Hello world !
                            [attributes:protected] => Array
                                (
                                    [startLine] => 1
                                    [endLine] => 1
                                    [kind] => 1
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
								'echo \'Hello world !\';' );
			}
		}
