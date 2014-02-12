package Gtk2::ImageViewer;

use 5.008;
use strict;
use warnings;

use Gtk2;

require DynaLoader;

our @ISA = qw(DynaLoader);

our $VERSION = '0.03';

sub dl_load_flags { 0x01 }

bootstrap Gtk2::ImageViewer $VERSION;

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Gtk2::ImageViewer - Perl interface to the GtkImageViewer

=head1 SYNOPSIS

  use Gtk2::ImageViewer;
  Gtk2->init;

  $window = Gtk2::Window->new();

  $imgv = new_from_file Gtk2::ImageViewer(shift);
  $window->add($imgv);

  $window->show_all();

main Gtk2;

  $imgv = new_from_file Gtk2::ImageViewer($filename);
  
  Gtk2->main;

=head1 ABSTRACT

  Perl bindings to the 2.x series of the Gtk Image Viewer widget.

=head1 DESCRIPTION

The Gtk2::ImageViewer module allows a perl developer to use the Gtk
Image Viewer Widget. The Gtk ImageViewer widget is an interactive
image viewer. See http://imagic.weizmann.ac.il/~dov/freesw/gtk/gtk-image-viewer
for an explanation.

To discuss gtk2-perl, ask questions and flame/praise the authors,
join gtk-perl-list@gnome.org at lists.gnome.org.

=head1 SEE ALSO

perl(1), Glib(3pm), Gtk2(3pm)

=head1 AUTHOR

Dov Grobgeld E<lt>dov@imagic.weizmann.ac.ilE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Dov Grobgeld.

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with this library; if not, write to the 
Free Software Foundation, Inc., 59 Temple Place - Suite 330, 
Boston, MA  02111-1307  USA.

=cut
