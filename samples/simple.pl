#!/usr/bin/perl

######################################################################
#  Trivial use of GtkImageViewer.
######################################################################

use Gtk2::ImageViewer;

Gtk2->init;

$window = Gtk2::Window->new();

$imgv = new_from_file Gtk2::ImageViewer(shift||"cat.jpg");
$window->add($imgv);

$window->show_all();

main Gtk2;
