<?php

require __DIR__ . '/../vendor/autoload.php';

use PhpLang\Phack\Test;

class PhackBasicTest extends PHPUnit_Framework_TestCase {
    use Test\AssertTranspilesTrait;

    public function testParseHackLang() {
       $this->assertTranspiles('echo "Hello World";', 'echo "Hello World"; ');
    }
}
