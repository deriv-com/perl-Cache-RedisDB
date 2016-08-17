use lib 't';

use utf8;
use lib '/tmp/new_sereal/local/lib/perl5';
use Sereal 3.014;
use Sereal::Decoder 3.014;
use Sereal::Encoder 3.014;
use Test::Most 0.22;
use Test::FailWarnings;
use DateTime;
use JSON qw(from_json);
use RedisServer;
use Cache::RedisDB;
use strict;

is($Sereal::VERSION, 3.014);
is($Sereal::Decoder::VERSION, 3.014);
is($Sereal::Encoder::VERSION, 3.014);

my $cache = Cache::RedisDB->redis;

is(Cache::RedisDB->get("Test", "ascii"), "This is ascii", "Get ascii.");
is(Cache::RedisDB->get("Test", "Chinese"), "它的工程", "Get Chinese.");
is(Cache::RedisDB->get("Test", "German"),"derbys s'équilibrent à l'exception","Get German");
eq_or_diff(Cache::RedisDB->get("Test", "HashRef"),
                          {
                           'ascii' => "This is ascii",
                           'Chinese' => "它的工程",
                           'German' => "derbys s'équilibrent à l'exception",
                          }, "get hash");
$cache->flushdb;
done_testing;
