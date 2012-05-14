package Resmon::Module::SMFMAINTENANCE;
use Resmon::ExtComm qw/cache_command/;
use vars qw/@ISA/;
@ISA = qw/Resmon::Module/;

# Sample config for resmon.conf
# (The module doesn't actually use anything other than 'services' to use as
#  a label)
# SMFMAINTENANCE {
#   services : noop
# }

sub handler {
  my $arg = shift;
  my $proc = $arg->{'object'};
  my $output = cache_command("/usr/bin/svcs | grep maintenance", 500);
  if($output) {
    $output =~s /^.*svc:\/(.+):[a-z]+$/\1/gm;
    chomp($output);
    $output =~s /\n/, /gs;
    return "BAD($output)";
  }
  return "OK(no services in maintenance mode)";
};
1;