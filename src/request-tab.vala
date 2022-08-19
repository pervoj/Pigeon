/* request-tab.vala
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

[GtkTemplate (ui = "/app/drey/Pigeon/request-tab.ui")]
public class Pigeon.RequestTab : Adw.Bin {
    public string title { get; set; default = ""; }

    [GtkChild]
    private unowned Gtk.Entry url_entry;

    [GtkChild]
    private unowned Gtk.DropDown method_dropdown;

    [GtkChild]
    private unowned Gtk.Button send_btn;

    private Gtk.Window parent_win;

    public RequestTab (Gtk.Window parent_win) {
        this.parent_win = parent_win;

        bind_property ("title", url_entry, "text", BindingFlags.BIDIRECTIONAL);

        method_dropdown.model = new Gtk.StringList (Request.methods);

        send_btn.clicked.connect (send);
    }

    private void send () {
        try {
            if (!Uri.is_valid (url_entry.text, UriFlags.NONE)) return;
        } catch {
            show_error_dialog (_("Error"), _("The URL is not valid!"));
            return;
        }

        send_btn.sensitive = false;

        try {

            var request = new Request ();
            request.url = url_entry.text;
            request.method = Request.methods[method_dropdown.selected];

            var response = request.send ();
            print ("%s\n", (string) response.get_bytes ().get_data ());
        } catch (Error e) {
            show_error_dialog (_("Error"), e.message);
        }

        send_btn.sensitive = true;
    }

    private void show_error_dialog (
        string title,
        string? content = null
    ) {
        var dialog = new Gtk.MessageDialog.with_markup (
            parent_win,
            Gtk.DialogFlags.DESTROY_WITH_PARENT | Gtk.DialogFlags.MODAL,
            Gtk.MessageType.ERROR,
            Gtk.ButtonsType.OK,
            title
        );
        if (content != null) dialog.format_secondary_markup (content);
        dialog.response.connect (() => { dialog.close (); });
        dialog.present ();
    }
}
