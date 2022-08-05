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

public enum Pigeon.RequestMethod {
    GET,
    POST;

    public string to_string () {
        switch (this) {
            case GET:
                return "GET";
            case POST:
                return "POST";
            default:
                assert_not_reached ();
        }
    }
}

public class Pigeon.Request : Object {
    private Cancellable cancellable = new Cancellable ();
    public RequestMethod method { get; set; default = RequestMethod.GET; }
    public Uri uri { get; construct; }

    public Request (Uri uri) {
        Object (uri: uri);
    }

    public Response send () throws Error {
        var session = new Soup.Session ();
        var message = new Soup.Message.from_uri (method.to_string (), uri);
        var response = session.send_and_read (message, cancellable);
        return new Response (response, session, message);
    }

    public void cancel () {
        cancellable.cancel ();
    }
}
