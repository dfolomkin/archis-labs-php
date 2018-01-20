<?php
    $host = "localhost";
    $user = "root";
    $pass = "";
    $db_name="new_schema";
    
    $link = mysqli_connect($host, $user, $pass, $db_name);
    mysqli_query($link, "set names utf8");
    
    