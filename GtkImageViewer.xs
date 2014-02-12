#include "gtk2perl.h"
#include "gtk-image-viewer.h"
#include "gtkimageviewerperl-autogen.h"

MODULE = Gtk2::ImageViewer	PACKAGE = Gtk2::ImageViewer	PREFIX = gtk_image_viewer_

GtkWidget *
gtk_image_viewer_new (class, image = NULL)
		SV * class
		GdkPixbuf* image
	C_ARGS:
		image

GtkWidget *
gtk_image_viewer_new_from_file (class, file = "")
		SV * class
		char* file
	C_ARGS:
		file

GdkPixbuf * 
gtk_image_viewer_get_image(image_viewer)
	GtkImageViewer * image_viewer

void
gtk_image_viewer_get_scale_and_shift(image_viewer)
	GtkImageViewer * image_viewer
	PPCODE:
	{
	    double sx,sy;
            int shift_x, shift_y;

	    gtk_image_viewer_get_scale_and_shift(image_viewer, &sx,&sy, &shift_x, &shift_y);
	    XPUSHs(sv_2mortal(newSVnv(sx)));
            XPUSHs(sv_2mortal(newSVnv(sy)));
	    XPUSHs(sv_2mortal(newSViv(shift_x)));
            XPUSHs(sv_2mortal(newSViv(shift_y)));
	}

void
gtk_image_viewer_set_scale_and_shift(image_viewer, scale_x, scale_y, shift_x, shift_y)
	GtkImageViewer *	image_viewer
	double scale_x;
	double scale_y;
        int shift_x;
        int shift_y;

guint
gtk_image_viewer_get_type()


void
gtk_image_viewer_set_image(widget, image)
	GtkImageViewer*	widget
	GdkPixbuf*	image

int
gtk_image_viewer_set_file(widget, file)
	GtkImageViewer*	widget
	char*	file


guint          
gtk_image_viewer_get_canvas_width(widget)
	GtkImageViewer*	widget

guint
gtk_image_viewer_get_canvas_height(widget)
	GtkImageViewer*	widget

void
gtk_image_viewer_img_coord_to_canv_coord(widget,imgx,imgy)
	GtkImageViewer*	widget
	double			imgx
	double			imgy
	PPCODE:
	{
	    double cx,cy;

	    gtk_image_viewer_img_coord_to_canv_coord(widget, imgx,imgy, &cx,&cy);
	    XPUSHs(sv_2mortal(newSVnv(cx)));
            XPUSHs(sv_2mortal(newSVnv(cy)));
	}

void
gtk_image_viewer_canv_coord_to_img_coord(widget,cx,cy)
	GtkImageViewer*	widget
	double			cx
	double			cy
	PPCODE:
	{
	    double imgx,imgy;

	    gtk_image_viewer_canv_coord_to_img_coord(widget, cx,cy,&imgx,&imgy);
	    XPUSHs(sv_2mortal(newSVnv(imgx)));
            XPUSHs(sv_2mortal(newSVnv(imgy)));
	}

gint           
gtk_image_viewer_zoom_around_fixed_point(widget,new_scale_x, new_scale_y, old_x, old_y, new_x, new_y)
	GtkImageViewer*	widget
	double new_scale_x
	double new_scale_y
	double old_x
	double old_y
	double new_x
	double new_y

void
gtk_image_viewer_zoom_fit(widget)
	GtkImageViewer* widget

void
gtk_image_viewer_expose_area(widget,x0,y0,w,h)
	GtkImageViewer*	widget
	int x0
	int y0
	int w
	int h

void
gtk_image_viewer_set_scroll_region(widget,x0,y0,x1,y1)
	GtkImageViewer *widget
	double x0
	double y0
	double x1
	double y1     

void
gtk_image_viewer_set_flip(widget,do_vflip,do_hflip)
	GtkImageViewer *widget
	gboolean do_vflip
	gboolean do_hflip

void 	
gtk_image_viewer_zoom_reset(widget)
	GtkImageViewer *widget

void 	
gtk_image_viewer_set_fill_on_resize(widget, whether)
	GtkImageViewer *widget
	gboolean whether

gint 	
gtk_image_viewer_redraw	(widget, clear_cache)
	GtkImageViewer *widget
	gboolean clear_cache

BOOT:
#include "register.xsh"
#include "boot.xsh"
