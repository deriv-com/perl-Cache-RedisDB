use Test::More tests => 1;
use Test::FailWarnings;
use Test::Exception;

use Cache::RedisDB;

# set environment variable for redis connection info
$ENV{REDIS_CACHE_SERVER} = '127.0.0.1:0000';

throws_ok { Cache::RedisDB->redis } qr/\QCannot connect to server (host 127.0.0.1 port 0000)/, 'Failed to connect redis-server';
