# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

package BZStestLicensePrivateFail;
BEGIN { system './makeLicenseMod.pl 12345 TestModule';
	system './makeLicenseMod.pl 1 Nest1';
	use vars qw( $ptr2_License );
	$| = 1; print "1..2\n";
$ENV{SERVER_NAME} = 'FOO';		# bogus server name
}
END {print "not ok 1\n" unless $loaded;
}
eval qq{use Crypt::C_LockTite;};
my $skip = $@;

$ptr2_License = {
	'private'	=> 'TestModule',
	'path'		=> do {$_ = `/bin/pwd`; chomp;$_} . '/TestCert.license',
};

use lib qw(.);
$loaded = 1;
print "ok 1\n";

unless ( $skip ) {
  eval "require TestModule";
  print 'not ' unless $@;			# should have been a fail
  print "ok 2\n";
} else {
  print "ok skip test on this platform ";
}
