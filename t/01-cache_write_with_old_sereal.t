use lib 't';

use utf8;
use lib '/tmp/old_sereal/local/lib/perl5';
use Sereal 2.011;
use Sereal::Decoder 2.01;
use Sereal::Encoder 2.01;
use Test::Most 0.22;
use Test::FailWarnings;
use DateTime;
use JSON qw(from_json);
use RedisServer;
use Cache::RedisDB;
use strict;

is($Sereal::VERSION, 2.011);
is($Sereal::Decoder::VERSION, 2.01);
is($Sereal::Encoder::VERSION, 2.01);


my $cache = Cache::RedisDB->redis;


$cache->flushdb;

ok(Cache::RedisDB->set("Test", "ascii", "This is ascii"), "Set ascii.");
ok(Cache::RedisDB->set("Test", "Chinese", "它的工程"), "Set Chinese.");
ok(Cache::RedisDB->set("Test", "German","derbys s'équilibrent à l'exception"), "Set German");
ok(Cache::RedisDB->set("Test", "HashRef",
                          {
                           'ascii' => "This is ascii",
                           'Chinese' => "它的工程",
                           'German' => "derbys s'équilibrent à l'exception",
                          }
                         ), "set hash");


is(Cache::RedisDB->get("Test", "ascii"), "This is ascii", "Get ascii.");
is(Cache::RedisDB->get("Test", "Chinese"), "它的工程", "Get Chinese.");
is(Cache::RedisDB->get("Test", "German"),"derbys s'équilibrent à l'exception","Get German");
eq_or_diff(Cache::RedisDB->get("Test", "HashRef"),
           {
            'ascii' => "This is ascii",
            'Chinese' => "它的工程",
            'German' => "derbys s'équilibrent à l'exception",
           }, "get hash");


done_testing;
