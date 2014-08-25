use Test::More tests => 1;
use Test::FailWarnings;
use Test::Exception;

use Cache::RedisDB;

# set environment variable for redis connection info
$ENV{REDIS_CACHE_SERVER} = '127.0.0.1:0000';

is  ( Cache::RedisDB->redis, undef, 'Failed to connect redis-server');
