﻿<?php 
            $partner = "16960";//商户ID
            $Key = "270bbae38500459a90b7b2f49a9aa6ba";//商户KEY
            $orderstatus = $_GET["orderstatus"];
            $ordernumber = $_GET["ordernumber"];
            $paymoney = $_GET["paymoney"];
            $sign = $_GET["sign"];
            $attach = $_GET["attach"];
            $signSource = sprintf("partner=%s&ordernumber=%s&orderstatus=%s&paymoney=%s%s", $partner, $ordernumber, $orderstatus, $paymoney, $Key); 
            if ($sign == md5($signSource))//签名正确
            {
                //此处作逻辑处理
            }
			echo('ok');exit;

?>