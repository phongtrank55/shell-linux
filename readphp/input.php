<?php
define('CLI_SCRIPT', true);
$pathmoodle = $argv[1];
$pathconfig = $pathmoodle.'/config.php';

require_once($pathconfig);

print_r($CFG);
?>

