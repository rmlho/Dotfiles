#!/usr/bin/env python3
import gi, sys, math, threading
gi.require_version('cairo', '1.0')
import cairo
from gi.repository import Gtk, GLib, Gdk

volume = int(sys.argv[1]) if len(sys.argv) > 1 else 50
muted = len(sys.argv) > 2 and sys.argv[2] == 'muted'

class VolumeOSD(Gtk.Window):
    def __init__(self):
        super().__init__(type=Gtk.WindowType.POPUP)
        self.set_default_size(280, 110)
        self.set_decorated(False)
        self.set_keep_above(True)
        self.set_skip_taskbar_hint(True)
        self.set_app_paintable(True)

        screen = self.get_screen()
        visual = screen.get_rgba_visual()
        if visual:
            self.set_visual(visual)

        display = Gdk.Display.get_default()
        monitor = display.get_monitor(0)
        geo = monitor.get_geometry()
        self.move(geo.x + geo.width - 310, geo.y + geo.height - 140)

        self.area = Gtk.DrawingArea()
        self.area.connect('draw', self.draw)
        self.add(self.area)
        self.show_all()

        GLib.timeout_add(1800, Gtk.main_quit)

    def draw(self, w, cr):
        W, H = 280, 110
        vol = volume / 100.0

        cr.set_operator(cairo.OPERATOR_SOURCE)
        cr.set_source_rgba(0.157, 0.157, 0.157, 0.97)
        cr.rectangle(0, 0, W, H)
        cr.fill()

        cr.set_source_rgb(0.314, 0.235, 0.196)
        cr.set_line_width(2)
        cr.rectangle(1, 1, W-2, H-2)
        cr.stroke()

        cx, cy, r = 55, 55, 30
        cr.set_source_rgb(0.235, 0.22, 0.196)
        cr.arc(cx, cy, r+8, 0, 2*math.pi)
        cr.fill()
        cr.set_source_rgb(0.392, 0.361, 0.314)
        cr.set_line_width(2)
        cr.arc(cx, cy, r+8, 0, 2*math.pi)
        cr.stroke()

        cr.set_source_rgb(0.235, 0.22, 0.196)
        cr.arc(cx, cy, r, 0, 2*math.pi)
        cr.fill()
        cr.set_source_rgb(0.4, 0.36, 0.31)
        cr.set_line_width(1.5)
        cr.arc(cx, cy, r, 0, 2*math.pi)
        cr.stroke()

        angle = -2.356 + vol * 4.712
        dot_r = r - 8
        dx = cx + dot_r * math.sin(angle)
        dy = cy - dot_r * math.cos(angle)
        color = (0.843, 0.6, 0.129) if not muted else (0.8, 0.141, 0.114)
        cr.set_source_rgb(*color)
        cr.arc(dx, dy, 4, 0, 2*math.pi)
        cr.fill()

        cr.set_source_rgb(0.486, 0.435, 0.392)
        cr.select_font_face('monospace')
        cr.set_font_size(9)
        cr.move_to(38, H-8)
        cr.show_text('VOL')

        x0, y0, bw, bh = 100, 30, 155, 8
        cr.set_source_rgb(0.235, 0.22, 0.196)
        cr.rectangle(x0, y0, bw, bh)
        cr.fill()
        cr.set_source_rgb(0.314, 0.235, 0.196)
        cr.set_line_width(1)
        cr.rectangle(x0, y0, bw, bh)
        cr.stroke()

        fill_color = (0.843, 0.6, 0.129) if not muted else (0.8, 0.141, 0.114)
        cr.set_source_rgb(*fill_color)
        cr.rectangle(x0, y0, bw * vol, bh)
        cr.fill()

        cr.set_source_rgb(*fill_color)
        cr.select_font_face('monospace')
        cr.set_font_size(28)
        text = 'MTD' if muted else f'{volume}%'
        cr.move_to(100, 78)
        cr.show_text(text)

        cr.set_source_rgb(0.486, 0.435, 0.392)
        cr.set_font_size(9)
        for i, lbl in enumerate(['0', '25', '50', '75', '100']):
            cr.move_to(x0 + (bw * i/4) - 4, y0 + 20)
            cr.show_text(lbl)

win = VolumeOSD()
Gtk.main()
