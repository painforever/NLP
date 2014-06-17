<?php
//preg_match_all("/\w+\s+/","this is a fucking Chinese haha",$match);
//preg_match_all("/<[^>]+>(.*)<\/[^>]+>/iU", "<b>example: </b><div align=left>this is a test</div><p>wocao ni ma</p>",$out, PREG_SET_ORDER);
preg_match_all("/<[^>]+>(.*?)<\/[^>]+>/", "<b>example: </b><div align=left>this is a test</div><p>wocao ni ma</p>",$out);
//print_r($out);
//var_dump(preg_match("/\d+/","2534"));
var_dump(preg_match_all("/\d+/","jfddsj",$ooo));
