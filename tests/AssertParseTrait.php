<?php

namespace PhpLang\Phack\Test;
use PhpLang\Phack;

trait AssertParseTrait {
	    private function assertParse($expectedAst, $hack) {
		       $normalize = function ($str) { return preg_replace('/\s+/', ' ', str_replace("\n", ' ', $str)); };
		       $ast = print_r(Phack\compileString('<?hh ' . $hack), true);
		       $this->assertEquals($expectedAst, $ast);
		    }
		}
