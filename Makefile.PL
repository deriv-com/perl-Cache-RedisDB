use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Cache::RedisDB',
    AUTHOR           => q{binary.com <rakesh@binary.com>},
    VERSION_FROM     => 'lib/Cache/RedisDB.pm',
    ABSTRACT_FROM    => 'lib/Cache/RedisDB.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.010,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
	'Test::Most' => 0.22,
	'Test::FailWarnings' => 0,
	'DateTime' => 0,
	'JSON' => 0
    },
    PREREQ_PM => {
        'RedisDB' => 2.14,
        'Sereal'  => 0,
    },
    (! eval { ExtUtils::MakeMaker->VERSION(6.46) } ? () :
        (META_ADD => {
            resources => {
                homepage   => 'https://github.com/binary-com/perl-Cache-RedisDB',
                repository => 'git@github.com:binary-com/perl-Cache-RedisDB.git',
                bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Cache-RedisDB',
            },
        })
    ),
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Cache-RedisDB-*' },
);
