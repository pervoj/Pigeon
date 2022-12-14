/* application.vala
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

public class Pigeon.Application : Adw.Application {
    public Application () {
        Object (
            application_id: Constants.APP_ID,
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    construct {
        ActionEntry[] action_entries = {
            { "about", this.on_about_action },
            { "preferences", this.on_preferences_action },
            { "quit", this.quit }
        };
        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", {"<primary>q"});
    }

    public override void activate () {
        this.resource_base_path = Constants.RESOURCE_PATH_PREFIX;
        base.activate ();
        var win = this.active_window;
        if (win == null) {
            win = new Window (this);
        }
        win.present ();
    }

    public static int main (string[] args) {
        // enable gettext
        // https://docs.gtk.org/glib/i18n.html
        Intl.setlocale (LocaleCategory.ALL, "");
        Intl.bindtextdomain (Constants.GETTEXT_PACKAGE, Constants.LOCALE_DIR);
        Intl.bind_textdomain_codeset (Constants.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Constants.GETTEXT_PACKAGE);

        var app = new Application ();
        return app.run (args);
    }

    private void on_about_action () {
        string[] authors = { "Vojtěch Perník" };
        Gtk.show_about_dialog (
            this.active_window,
            "program-name", _("Pigeon"),
            "comments", _("Easily test your APIs"),
            "logo-icon-name", Constants.APP_ID,
            "copyright", _("Copyright \xc2\xa9 2022 Vojtěch Perník"),
            "authors", authors,
            // Translators: Here write your names, or leave it empty. Each name on new line. You can also add email (John Doe <j.doe@example.com>). Do not translate literally!
            "translator-credits", _("translator-credits"),
            "version", Constants.VERSION,
            "license-type", Gtk.License.GPL_3_0,
            "website", "https://gitlab.gnome.org/pervoj/Pigeon"
        );
    }

    private void on_preferences_action () {
        message ("app.preferences action activated");
    }
}
