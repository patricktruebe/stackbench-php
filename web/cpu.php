<?php
define('BENCHTIME', 2);

function get_mibs_used() {
  return memory_get_usage() / 1048576.0;
}

$start = microtime (true );
$buffer = "";
for ($i=0; microtime(true) - $start < BENCHTIME; $i++ )
{
    openssl_random_pseudo_bytes ( 1024 );
    $buffer .= openssl_random_pseudo_bytes ( 512 );
}
printf("Took %d loops for %f seconds load\n", $i,BENCHTIME);
printf("Allocated peak mem was %d MiB\n", get_mibs_used());
