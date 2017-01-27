# HackLang parser

## What is this?

This project is a parser for [HackLang](http://www.hacklang.org) written in PHP. It is based on Sara Golemon's project [Phack](https://github.com/phplang/phack/). It builds an abstract Syntax Tree (AST) from HackLang source code.

Any attempt to use HackLang files which have not passed `hh_client` is a terrible mistake, and you should feel bad.

## How does it work?

Hack Parser extends [PHP-Parser](https://www.github.com/nikic/PHP-Parser) by amending the PHP 7 parsing rules and overriding the Lexer's pre/post processor hooks.

## How do I use it?

The prefered way of installation is via composer. For this, add the following to your `composer.json`:


    "repositories": [
        {
            "type": "vcs",
            "url": "<git_repository_url>"
        }
    ],
    "require": {
        "adel/hackparser": "*"
    }

To Parse a HackLang file, use `new PhpLang\Phack\PhpParser\ParserFactory)->create(PhpLang\Phack\PhpParser\ParserFactory::HACKLANG)->parse($str);`. This returns an abstract syntax tree that can be used for static analysis for example. More informations in the [PHP-Parser documentation](https://github.com/nikic/PHP-Parser/tree/2.x/doc).

To see the AST of a given HackLang file, you can run `vendor/bin/hackParser` which will invoke `compileString` for you and dump the tree.
