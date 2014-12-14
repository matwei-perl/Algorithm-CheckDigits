# vim: set ts=4 sw=4 tw=78 et si:
use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    add_to_cleanup      => [ 'Algorithm-CheckDigits-*' ],
    build_requires      => {
        'Probe::Perl'   => 0,
        'Test::More'    => 0,
    },
    configure_requires  => { 'Module::Build' => 0.38 },
    create_makefile_pl  => 'small',
    dist_author         => 'Mathias Weidner <mamawe@cpan.org>',
    dist_version_from   => 'lib/Algorithm/CheckDigits.pm',
    license             => 'perl',
    module_name         => 'Algorithm::CheckDigits',
    requires            => { 
    	'version'       => 0,
    },
    script_files        => [
        'bin/checkdigits.pl',
    ],
);

$builder->create_build_script();
