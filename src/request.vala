/* request.vala
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

public class Pigeon.Request : Object {
    public const string[] methods = {
        "GET",
        "POST"
    };

    private Cancellable cancellable = new Cancellable ();
    public string method { get; set; default = "GET"; }
    public string url { get; set; default = "https://www.gnome.org/"; }

    public Response send () throws Error {
        var session = new Soup.Session ();
        var message = new Soup.Message (method, url);
        var response = session.send_and_read (message, cancellable);
        return new Response (response, session, message);
    }

    public void cancel () {
        cancellable.cancel ();
    }
}
