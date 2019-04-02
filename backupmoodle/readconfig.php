<?php


function writefile($path, $data){
	$myfile = fopen($path, "w");
	foreach($data as $value){
		fwrite($myfile, "$value\n");
	}
	fclose($myfile);
}

define('CLI_SCRIPT', true);
$pathmoodle = $argv[1];
$pathoutput = $argv[2];
$pathconfig = $pathmoodle.'/config.php';

// Dong 1: dbtype
// Dong 2: dbuser
// Dong 3: dbpass
// Dong 4: dbname
// Dong 5: dataroot

require_once($pathconfig);
$keys = ['dbtype', 'dbuser', 'dbpass', 'dbname', 'dataroot'];
foreach($keys as $key){
	$data[] = $CFG->{$key} ? trim($CFG->{$key}) : "-";
}

writefile($pathoutput, $data);

?>

