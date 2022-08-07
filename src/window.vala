/* window.vala
 *
 * Copyright 2022 Vojtěch Perník
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

[GtkTemplate (ui = "/app/drey/Pigeon/window.ui")]
public class Pigeon.Window : Adw.ApplicationWindow {
    [GtkChild]
    private unowned Adw.TabView tab_view;

    [GtkChild]
    private unowned Gtk.Button new_tab_btn;

    public unowned Adw.TabView get_tab_view () {
        return tab_view;
    }

    public Window (Gtk.Application app, bool create_tab = true) {
        Object (application: app);

        tab_view.create_window.connect (() => {
            var win = new Window (app, false);
            win.present ();
            return win.get_tab_view ();
        });

        new_tab_btn.clicked.connect (this.create_tab);

        if (create_tab) this.create_tab ();
    }

    private void create_tab () {
        var entry = new Gtk.Entry ();
        var tab = tab_view.append (entry);
        entry.bind_property ("text", tab, "title", BindingFlags.SYNC_CREATE,
            (binding, from_value, ref to_value) => {
                if (from_value.get_string () == "") {
                    to_value.set_string (_("Untitled Request"));
                } else {
                    to_value.set_string (from_value.get_string ());
                }
                return true;
            }
        );
    }
}
