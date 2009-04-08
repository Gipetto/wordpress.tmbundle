<?php
// parser to scan a wordpress install and build a list of functions for TextMate function completion
$path = '/Users/shawn/Sites/wordpress_';
$version = '2.7';

// get all the function declarations from the wordpress install
$command = 'find '.$path.$version.' ! \( -path "*svn*" -o -path "*theme*" -o -path "*plugins*" -o -path "*wp-plugins*" -o -path "*.js" \) |xargs grep -En "function (&?)(.*?)\((.*?)\)"';
exec($command,$ret);

// build the functions list
$functions = array();
foreach($ret as $line) {
	// echo $line.PHP_EOL;
	if(preg_match('|^.*function (.*?)\((.*?)\)(\s?){.*?$|',$line,$matches)) {
		$name = trim($matches[1],' &');
		if($name{0} == '_') { continue; } // skip "private"/"internal" functions and magic methods
		$args = $matches[2];
		$args = str_replace("', '","','",$args); // a little hackery to catch default comma values being passed
		$args_a = trim($args) != '' ? explode(', ',$args) : null;
		
		if(count($args_a)) {
			foreach($args_a as &$arg) {
				// remove reference designator
				$arg = trim($arg,' &');
				// handle no param functions
				if(strlen($arg) == 0) { 
					$arg = null;
					continue; 
				}
				// if no default value, create a generic one to make further parsing easier
				// unless a param name is matched, this will default the param def to string
				if(strpos($arg, '=') == false) {
					$arg .= " = ''";
				}
				
				$p = array_map('trim',explode('=',$arg));
				// map param vars to types
				$type = '';
				switch(true) {
					// special string cases, need to catch early despite the duplicate type assignment
					case $p[0] == '$src' && $name == 'wp_enqueue_script':
					case $p[0] == '$src' && $name == 'wp_enqueue_style':
						$type = 'string';
						break;
					// floats
					case $p[0] == '$ver':
						$type = 'float';
						break;
					// booleans
					case $p[1] == 'true':
					case $p[1] == 'false':
					case $p[0] == '$force':
					case $p[0] == '$suspend':
						$type = 'bool';
						break;
					// objects
					case $p[0] == '$object':
					case $p[0] == '$post':
					case $p[0] == '$category':
						$type = 'object';
						break;
					// arrays
					case $p[0] == '$cron':
					case $p[0] == '$deps':
					case $p[0] == '$args':
					case $p[0] == '$mimes':
					case $p[0] == '$handles':
					case $p[0] == '$defaults':
					case $p[0] == '$commentdata':
					case strpos($p[0],'array') != false:
					case strpos($p[1],'array') != false:
						$type = 'array';
						break;
					// integers
					case $p[0] == '$id':
					case $p[0] == '$postID':
					case preg_match('|(.*?)_id|',$p[0]):
					case $p[0] == '$timestamp':
					case $p[0] == '$length':
					case preg_match('|([0-9]+)|',$p[1]):
						$type = 'int';
						break;
					// constants
					case strpos($p[1],'ENT_') != false:
						$type = 'constant';
						break;
					// string, default
					case $p[1] == "''":
					case $p[1] == '""':
					default:
						$type = 'string';
						$p[1] = '';
				}			
				
				// assign to storage array
				$arg = array(
					'name' => ltrim($p[0],'$'),
					'type' => $type,
					'value' => $p[1]
				);
			}
		}
		
		// add to global array
		$functions[$name] = array(
			'name' => $name,
			'args' => $args_a
		);
		ksort($functions);
		
		// echo 'Name: '.$name.PHP_EOL;
		// echo 'Params: '.$args.PHP_EOL;
		// echo 'Args: '.print_r($args_a,true).PHP_EOL;
		// 		
		// echo PHP_EOL;
	}
}

// make files
if(count($functions)) {
	make_completions($functions);
	echo 'completions file written';
	make_functions($functions);
	echo 'functions file written';
}
else {
	echo 'no completions file made, no functions in array';
}

// function to build a completions file
function make_completions($functions) {
	$xml = '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist public "-//Apple Computer//DTD PLIST 1.0//ENhttp://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>name</key>
    <string>Completions</string>
    <key>scope</key>
    <string>source.php</string>
    <key>settings</key>
    <dict>
      <key>completions</key>
      <array>';
	foreach($functions as $func) {
        $xml .= '
		<string>'.$func['name'].'</string>';
	}
$xml .= '
      </array>
    </dict>
    <key>uuid</key>
    <string>2543E52B-D5CF-4BBE-B793-51F1574EA05F</string>
  </dict>
</plist>';
	file_put_contents('Completions.tmPreferences',$xml);
}

// function to make the function completion defs file
function make_functions($functions) {
	$itmes = array();
	foreach($functions as $function) {
		$insert = '';
		$i = 1;
		if(is_array($function['args']) && count($function['args'])) {
			$vars = array();
			foreach($function['args'] as $arg) {
				$vars[] = '${'.$i++.':'.$arg['type'].' '.$arg['name'].'}';
			}
			$insert = implode(', ',$vars);
		}
		$items[] = "\t{display = '".$function['name']."'; insert = '(".$insert.")';}";
	}
	$plist = '('.PHP_EOL.implode(','.PHP_EOL,$items).PHP_EOL.')';
	file_put_contents('functions.plist',$plist);
}

?>