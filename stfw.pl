
use Purple;
%PLUGIN_INFO = (
    perl_api_version => 2,
    name => "STFW",
    version => "0.1",
    summary => "Return lmgtfy.com query link for string.",
    description => "Usage: /stfw <string> - Return a link to lmgtfy.com to search for the given string.",
    author => "Andrew L. Vandever <andrew.vandever\@gmail.com>",
    url => "http://pidgin.im",
    load => "plugin_load",
    unload => "plugin_unload"
);
sub plugin_init {
    return %PLUGIN_INFO;
}
sub plugin_load {
    my $plugin = shift;
	my $conv = Purple::Conversations::get_handle();
	Purple::Cmd::register($plugin, "stfw", "s", Purple::Cmd::Priority::DEFAULT,
			Purple::Cmd::Flag::IM | Purple::Cmd::Flag::CHAT,
			0, \&stfw_cb,"",$plugin);
    Purple::Debug::info("STFW", "plugin_load() - STFW Plugin Loaded.\n");
}
sub plugin_unload {
    my $plugin = shift;
    Purple::Debug::info("STFW", "plugin_unload() - STFW Plugin Unloaded.\n");
}

sub stfw_cb {
  my ($conv, $cmd, $plugin, @args) = @_;
  my $lmgtfy_prefix = "http://lmgtfy.com/?q=";
  my @words = split(/\s+/, $args[0]);
  my $msg = $lmgtfy_prefix.join("+", @words);
  my $sendmsg = $conv->get_im_data();
  $sendmsg->send($msg);
  return Purple::Cmd::Ret::OK;
}