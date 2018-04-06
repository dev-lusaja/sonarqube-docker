<?php

class bad_example{
    public $attr1;
    public $attr2;

    public function __construct(){
        $this->attr1 = 1;
        $this->attr2 = 2;
        return true;
    }

    public function GoodFunction()
    {
        return true;
        var_dump("Hello World");
    }
}

class GoodExample{
    public $attr_1;
    public $attr_2;

    public function __construct(){
        $this->attr_1 = 1;
        $this->attr_2 = 2;
    }

    public function goodFunction()
    {
        return [$this->attr_1, $this->attr_1];
    }
}

$good_example = new GoodExample();
var_dump($good_example->goodFunction());