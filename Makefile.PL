use 5.008;
use ExtUtils::MakeMaker;
use Cwd;
use File::Spec;

# minimum required version of dependancies we need to build
our %build_reqs = (
	'perl-ExtUtils-Depends'   => '0.1',
	'perl-ExtUtils-PkgConfig' => '0.1',
	'perl-Glib'               => '1.03',
	'perl-Gtk2'               => '1.00',
	'GtkImageViewer'          => '1.0',
);

# minimum required version of dependancies we need to run
our %runtime_reqs = (
	'GtkImageViewer' => undef,
);

# Writing a fake Makefile ensures that CPAN will pick up the correct
# dependencies and install them.
unless (eval "use ExtUtils::Depends;"
           . "use ExtUtils::PkgConfig;"
           . "use Gtk2::CodeGen;"
           # just seeing if Glib is available isn't enough, make sure
           # it's recent enough, too 
           . "use Glib '$build_reqs{'perl-Glib'}';"
           . "use Gtk2 '$build_reqs{'perl-Gtk2'}';"
           . "1") {
   warn "$@\n";
   WriteMakefile(
         PREREQ_FATAL => 1,
         PREREQ_PM    => {
            Glib::                => $build_reqs{'perl-Glib'},
            Gtk2::                => $build_reqs{'perl-Gtk2'},
            ExtUtils::Depends::   => $build_reqs{'perl-ExtUtils-Depends'},
            ExtUtils::PkgConfig:: => $build_reqs{'perl-ExtUtils-PkgConfig'},
         },
   );
   exit 1; # not reached
}

%pkgcfg = ExtUtils::PkgConfig->find ('gtkimageviewer');

$runtime_reqs{GtkImageViewer} = $pkgcfg{modversion};

mkdir 'build', 0777;

#
# autogeneration
#
Gtk2::CodeGen->parse_maps ('gtkimageviewerperl');
Gtk2::CodeGen->write_boot;

# now we're ready to start creating the makefile.
# we need to use ExtUtils::Depends to get relevant information out of
# the Glib extension, and to save config information for other modules which
# will chain from this one.

$giv2 = ExtUtils::Depends->new ('Gtk2::ImageViewer', 'Gtk2', 'Glib');
$giv2->set_inc ($pkgcfg{cflags});
$giv2->set_libs ($pkgcfg{libs});
$giv2->add_xs (<*.xs>);
$giv2->add_pm ('ImageViewer.pm' => '$(INST_LIBDIR)/ImageViewer.pm');
my $cwd = cwd();
$giv2->add_typemaps (map {File::Spec->catfile($cwd,$_)} 'build/gtkimageviewerperl.typemap');
$giv2->add_headers ('gtkimageviewerperl.h');

$giv2->install (qw(build/gtkimageviewerperl-autogen.h));
$giv2->save_config ('build/IFiles.pm');

WriteMakefile(
    NAME            => 'Gtk2::ImageViewer',
    VERSION_FROM    => 'ImageViewer.pm', # finds $VERSION
    ABSTRACT_FROM   => 'ImageViewer.pm', # retrieve abstract from module
    XSPROTOARG      => '-noprototypes',
    $giv2->get_makefile_vars,
);

package MY;

sub postamble
{
	"
realclean ::
	-rm -Rf build
"
}
package MAIN;
