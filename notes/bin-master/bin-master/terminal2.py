# -*- coding: utf8 -*-

############################################################################
# terminal2.py - Embeded VTE terminal for gedit
# This file is part of gedit
#
# Copyright (C) 2005-2006 - Paolo Borelli
# Copyright (C) 2013  Lilian BESSON <lbesson at ens-cachan dot fr>
#
# gedit is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# gedit is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with gedit; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor,
# Boston, MA  02110-1301  USA
############################################################################
## To copy here : /usr/lib/gedit/plugins

""" A terminal embedded in Gedit lateral panel, v3.2.3."""

__author__ = "Paolo Borelli, Lilian BESSON <lbesson at ens-cachan dot fr> for Naereen CORP."
__version__ = "3.2.3"
__appname__ = "gedit-terminal2"
__app_disp_name__ = "Gedit Embeded Terminal Lateral"
__website__ = "https://sites.google.com/site/naereencorp/gedit/"

print ".:[ Initializing %s, v%s. (c) %s ]:." % (__app_disp_name__, __version__, __author__)
print ".:[ Take a look at %s for more informations, or for the latest version of this piece of software. ]:." % (__website__)

from gi.repository import GObject, GLib, Gio, Pango, Gdk, Gtk, Gedit, Vte
import os
import gettext
from gpdefs import *
from signal import SIGTERM, SIGKILL

try:
    gettext.bindtextdomain(GETTEXT_PACKAGE, GP_LOCALEDIR)
    _ = lambda s: gettext.dgettext(GETTEXT_PACKAGE, s);
except:
    _ = lambda s: s

class GeditTerminal2(Gtk.Box):
    """VTE terminal2 which follows gnome-terminal default profile options"""

    __gsignals__ = {
        "populate-popup": (
            GObject.SIGNAL_RUN_LAST,
            None,
            (GObject.TYPE_OBJECT,)
        )
    }

    defaults = {
        'emulation'             : 'xterm', # Don't try to put anything else here.
        'visible_bell'          : True, # NEW
        'audible_bell'          : True, # NEW
        #'opacity'          : 55000, # NEW
        'allow_bold'          : True, # NEW
    }

    def __init__(self):
        Gtk.Box.__init__(self)

        self.profile_settings = self.get_profile_settings()
        self.profile_settings.connect("changed", self.on_profile_settings_changed)
        self.system_settings = Gio.Settings.new("org.gnome.desktop.interface")
        self.system_settings.connect("changed::monospace-font-name", self.font_changed)

        self._vte = Vte.Terminal()
        self.reconfigure_vte()
        self._vte.set_size(self._vte.get_column_count(), 5)
        self._vte.set_size_request(200, 50)
        self._vte.show()
        self.pack_start(self._vte, True, True, 0)

        scrollbar = Gtk.Scrollbar.new(Gtk.Orientation.VERTICAL, self._vte.get_vadjustment())
        scrollbar.show()
        self.pack_start(scrollbar, False, False, 0)

        # we need to reconf colors if the style changes
        #FIXME: why?
        #self._vte.connect("style-update", lambda term, oldstyle: self.reconfigure_vte())
        self._vte.connect("key-press-event", self.on_vte_key_press)
        self._vte.connect("button-press-event", self.on_vte_button_press)
        self._vte.connect("popup-menu", self.on_vte_popup_menu)
        self._vte.connect("child-exited", self.on_child_exited)
#: FIXME: TypeError: on_child_exited() takes exactly 1 argument (2 given)
#:        self._vte.connect("child-exited", lambda (self2, term2): self2.on_child_exited() )
#:        print "Connecting child-exited to _vte, with :"
#:        print "lambda self2,term2: self2.on_child_exited()"

        self._accel_base = '<gedit>/plugins/terminal'
        self._accels = {
            'copy-clipboard': [Gdk.KEY_C, Gdk.ModifierType.CONTROL_MASK | Gdk.ModifierType.SHIFT_MASK, self.copy_clipboard],
            'paste-clipboard': [Gdk.KEY_V, Gdk.ModifierType.CONTROL_MASK | Gdk.ModifierType.SHIFT_MASK, self.paste_clipboard]
        }

        for name in self._accels:
            path = self._accel_base + '/' + name
            accel = Gtk.AccelMap.lookup_entry(path)

            if not accel[0]:
                 Gtk.AccelMap.add_entry(path, self._accels[name][0], self._accels[name][1])

        self._vte.fork_command_full(Vte.PtyFlags.DEFAULT, None, [Vte.get_user_shell()], None, GLib.SpawnFlags.SEARCH_PATH, None, None)

    def on_child_exited(self, term):
#:        print "on_child_exited have been called (shell is terminated)"
        print ".:[ Re-launching a shell, on %s, v%s. (c) %s ]:." % (__app_disp_name__, __version__, __author__)
        print ".:[ Take a look at %s for more informations, or for the latest version of this piece of software. ]:." % (__website__)
        print self._vte.fork_command_full(Vte.PtyFlags.DEFAULT, None, [Vte.get_user_shell()], None, GLib.SpawnFlags.SEARCH_PATH, None, None)

    def do_grab_focus(self):
        self._vte.grab_focus()

    def get_profile_settings(self):
        #FIXME return either the gnome-terminal settings or the gedit one
        return Gio.Settings.new("org.gnome.gedit.plugins.terminal")

    def get_font(self):
        if self.profile_settings.get_boolean("use-system-font"):
            font = self.system_settings.get_string("monospace-font-name")
        else:
            font = self.profile_settings.get_string("font")

        return font

    def font_changed(self, settings=None, key=None):
        font = self.get_font()
        font_desc = Pango.font_description_from_string(font)

        self._vte.set_font(font_desc)

    def reconfigure_vte(self):
        # Fonts
        self.font_changed()

        # colors
        context = self._vte.get_style_context()
        fg = context.get_color(Gtk.StateFlags.NORMAL)
        bg = context.get_background_color(Gtk.StateFlags.NORMAL)
        palette = []

        if not self.profile_settings.get_boolean("use-theme-colors"):
            fg_color = self.profile_settings.get_string("foreground-color")
            if fg_color != "":
                fg = Gdk.RGBA()
                parsed = fg.parse(fg_color)
            bg_color = self.profile_settings.get_string("background-color")
            if bg_color != "":
                bg = Gdk.RGBA()
                parsed = bg.parse(bg_color)
        str_colors = self.profile_settings.get_string("palette")
        if str_colors != "":
            for str_color in str_colors.split(':'):
                try:
                    rgba = Gdk.RGBA()
                    rgba.parse(str_color)
                    palette.append(rgba)
                except:
                    palette = []
                    break
            if (len(palette) not in (0, 8, 16, 24)):
                palette = []

        self._vte.set_colors_rgba(fg, bg, palette)

        self._vte.set_cursor_blink_mode(self.profile_settings.get_enum("cursor-blink-mode"))
        self._vte.set_cursor_shape(self.profile_settings.get_enum("cursor-shape"))
        self._vte.set_audible_bell(not self.profile_settings.get_boolean("silent-bell"))
        self._vte.set_allow_bold(self.profile_settings.get_boolean("allow-bold"))
        self._vte.set_scroll_on_keystroke(self.profile_settings.get_boolean("scrollback-on-keystroke"))
        self._vte.set_scroll_on_output(self.profile_settings.get_boolean("scrollback-on-output"))
        self._vte.set_word_chars(self.profile_settings.get_string("word-chars"))
        self._vte.set_emulation(self.defaults['emulation'])
        self._vte.set_visible_bell(self.defaults['visible_bell'])
        # NEW.
        self._vte.set_audible_bell(self.defaults['audible_bell'])
        #self._vte.set_opacity(self.defaults['opacity'])
        self._vte.set_allow_bold(self.defaults['allow_bold'])

        if self.profile_settings.get_boolean("scrollback-unlimited"):
            lines = -1
        else:
            lines = self.profile_settings.get_int("scrollback-lines")
        self._vte.set_scrollback_lines(lines)

    def on_profile_settings_changed(self, settings, key):
        self.reconfigure_vte()

    def on_vte_key_press(self, term, event):
        modifiers = event.state & Gtk.accelerator_get_default_mod_mask()
        if event.keyval in (Gdk.KEY_Tab, Gdk.KEY_KP_Tab, Gdk.KEY_ISO_Left_Tab):
            if modifiers == Gdk.ModifierType.CONTROL_MASK:
                self.get_toplevel().child_focus(Gtk.DirectionType.TAB_FORWARD)
                return True
            elif modifiers == Gdk.ModifierType.CONTROL_MASK | Gdk.ModifierType.SHIFT_MASK:
                self.get_toplevel().child_focus(Gtk.DirectionType.TAB_BACKWARD)
                return True

        for name in self._accels:
            path = self._accel_base + '/' + name
            entry = Gtk.AccelMap.lookup_entry(path)

            if entry and entry[0] and entry[1].accel_key == event.keyval and entry[1].accel_mods == modifiers:
                self._accels[name][2]()
                return True

        return False

    def on_vte_button_press(self, term, event):
        if event.button == 3:
            self._vte.grab_focus()
            self.make_popup(event)
            return True

        return False

    def on_vte_popup_menu(self, term):
        self.make_popup()

    def create_popup_menu(self):
        menu = Gtk.Menu()

        item = Gtk.ImageMenuItem.new_from_stock(Gtk.STOCK_COPY, None)
        item.connect("activate", lambda menu_item: self.copy_clipboard())
        item.set_accel_path(self._accel_base + '/copy-clipboard')
        item.set_sensitive(self._vte.get_has_selection())
        menu.append(item)

        item = Gtk.ImageMenuItem.new_from_stock(Gtk.STOCK_PASTE, None)
        item.connect("activate", lambda menu_item: self.paste_clipboard())
        item.set_accel_path(self._accel_base + '/paste-clipboard')
        menu.append(item)

        #MenuItem => separator
        item = Gtk.SeparatorMenuItem()
        menu.append(item)

        #MenuItem => About
        item = Gtk.ImageMenuItem.new_from_stock("gtk-about", None)
        item.connect("activate", lambda menu_item: self.show_about_dialog())
        menu.append(item)

        self.emit("populate-popup", menu)
        menu.show_all()
        return menu

    def make_popup(self, event = None):
        menu = self.create_popup_menu()
        menu.attach_to_widget(self, None)

        if event is not None:
            menu.popup(None, None, None, None, event.button, event.time)
        else:
            menu.popup(None, None,
                       lambda m: Gedit.utils_menu_position_under_widget(m, self),
                       None,
                       0, Gtk.get_current_event_time())
            menu.select_first(False)

    def copy_clipboard(self):
        self._vte.copy_clipboard()
        self._vte.grab_focus()

    def paste_clipboard(self):
        self._vte.paste_clipboard()
        self._vte.grab_focus()

    def change_directory(self, path):
        path = path.replace('\\', '\\\\').replace('"', '\\"')
        self._vte.feed_child('cd "%s" # Inserted by Gnome-Terminal.\n' % path, -1)
        self._vte.grab_focus()

    def show_about_dialog(self):
        """Display the about dialog."""
        about_dlg = Gtk.AboutDialog()
        #Set the content of the dialog
        about_dlg.set_program_name(__app_disp_name__)
        about_dlg.set_version(__version__)
        about_dlg.set_comments(__doc__)
        about_dlg.set_website(__website__)
        about_dlg.set_copyright("Copyright (c) 2005-13  %s" % __author__)
#: FIXME : on doit aller la chercher + intelligemment.
        logo = Gtk.Image.new_from_file("/usr/share/icons/gnome/32x32/apps/terminal.png") # 32x32
        about_dlg.set_logo(logo.get_pixbuf())
        #Signal
        about_dlg.connect("response", lambda w, r: w.destroy())
        #Display the dialog
        about_dlg.show()

class TerminalPlugin2(GObject.Object, Gedit.WindowActivatable):
    __gtype_name__ = "TerminalPlugin2"

    window = GObject.property(type=Gedit.Window)

    def __init__(self):
        GObject.Object.__init__(self)

    def do_activate(self):
        self._panel = GeditTerminal2()
        self._panel.connect("populate-popup", self.on_panel_populate_popup)
        self._panel.show()

        image = Gtk.Image.new_from_icon_name("utilities-terminal", Gtk.IconSize.MENU)

        side = self.window.get_side_panel()
        side.add_item(self._panel, "GeditTerminal2Panel", _("Embedded Terminal"), image)
        # FIXME

    def do_deactivate(self):
        side = self.window.get_side_panel()
        side.remove_item(self._panel)

    def do_update_state(self):
        pass

    def get_active_document_directory(self):
        doc = self.window.get_active_document()
        if doc is None:
            return None
        location = doc.get_location()
        if location is not None and Gedit.utils_location_has_file_scheme(location):
            directory = location.get_parent()
            return directory.get_path()
        return None

    def on_panel_populate_popup(self, panel, menu):
        menu.prepend(Gtk.SeparatorMenuItem())
        path = self.get_active_document_directory()
        item = Gtk.MenuItem.new_with_mnemonic(_("C_hange Directory"))
        item.connect("activate", lambda menu_item: panel.change_directory(path))
        item.set_sensitive(path is not None)
        menu.prepend(item)

# Let's conform to PEP8
# ex:ts=4:et:
