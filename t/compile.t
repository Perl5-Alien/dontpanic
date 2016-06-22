use strict;
use warnings;
use autodie;
use 5.010;
use Test::More;
use File::Spec;
use File::Temp qw( tempdir );

my @LDFLAGS = ('-L' . File::Spec->rel2abs( 'src/.libs' ), '-Wl,-rpath,' . File::Spec->rel2abs( 'src/.libs' ));
my @CFLAGS  = ('-I' . File::Spec->rel2abs( 'src' ));
my @LIBS    = ('-ldontpanic');

note "LDFLAGS = @LDFLAGS";
note "CFLAGS  = @CFLAGS";
note "LIBS    = @LIBS";

chdir tempdir( CLEANUP => 1);;

open my $fh, '>', "dontpanictest.c";
print $fh do { local $/; <DATA> };
close $fh;

my @cmd = ($ENV{CC} // 'cc', -o => 'dontpanictest', @LDFLAGS, @CFLAGS, 'dontpanictest.c', @LIBS);
note "% @cmd";
system @cmd;

ok -x './dontpanictest', 'created executable';

system './dontpanictest';

is $?, 0, 'am able to execute';

chdir(File::Spec->rootdir);

done_testing;

__DATA__
#include <libdontpanic.h>

int
main(int argc, char *argv[])
{
  if(answer() == 42)
    return 0;
  else
    return 2;
}
