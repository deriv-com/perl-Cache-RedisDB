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

my $server = RedisServer->start;
plan(skip_all => "Can't start redis-server") unless $server;

$ENV{REDIS_CACHE_SERVER} = 'localhost:' . $server->{port};

my $cache = Cache::RedisDB->redis;

plan(skip_all => 'Redis Server Not Found') unless $cache;
plan(skip_all => "Test requires redis-server at least 1.2") unless $cache->version ge 1.003015;

diag "Redis server version: ". $cache->info->{redis_version};

my @version = split(/\./, $cache->info->{redis_version});
my $sufficient_version = 0;
$sufficient_version = 1;


plan (skip_all => 'Skipping full cache test due to Redis being below 2.6.12')
    unless $sufficient_version;
$cache->flushdb;

ok(Cache::RedisDB->set("Test", "ascii", "This is ascii"), "Set ascii.");
ok(Cache::RedisDB->set("Test", "Chinese", "它的工程"), "Set Chinese.");
ok(Cache::RedisDB->set("Test," "German","derbys s'équilibrent à l'exception"), "Set German");
ok(Cache::RedisDB->set("Test", "HashRef",
                          {
                           'ascii' => "This is ascii",
                           'Chinese' => "它的工程",
                           'German' => "derbys s'équilibrent à l'exception",
                          }
                         ), "set hash");

done_testing;
