use 5.008004;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

if ( $^O eq 'MSWin32' ) {
    die "On Win32 module requires perl >= 5.12" if not $^V or $^V lt v5.12;
}

WriteMakefile(
    NAME             => 'Cache::RedisDB',
    AUTHOR           => q{binary.com <rakesh@binary.com>},
    VERSION_FROM     => 'lib/Cache/RedisDB.pm',
    ABSTRACT_FROM    => 'lib/Cache/RedisDB.pm',
    LICENSE          => 'perl',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.010,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 6.3002,
    },
    BUILD_REQUIRES => {
        'Test::More'         => 0.96,
        'Test::Most'         => 0.22,
        'Test::Differences'  => 0.61,
        'Test::FailWarnings' => 0,
        'Test::TCP'          => 1.17,
        'Digest::SHA'        => 0,
        'DateTime'           => 0,
        'JSON'               => 0
    },
    PREREQ_PM => {
        'RedisDB' => 2.14,
        'Sereal'  => 0,
    },
    META_MERGE => {
        requires  => { perl => 5.008004, },
        resources => {
            homepage   => 'https://github.com/binary-com/perl-Cache-RedisDB',
            bugtracker => 'https://github.com/binary-com/perl-Cache-RedisDB/issues',
            repository => 'git@github.com:binary-com/perl-Cache-RedisDB.git',
            license    => 'http://dev.perl.org/licenses/',
        },
        keywords       => ['cache','redisdb'],
        x_contributors => [
            'Rakesh Kumar Shardiwal <shardiwal@cpan.org>',
        ],
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Cache-RedisDB-*' },
);
