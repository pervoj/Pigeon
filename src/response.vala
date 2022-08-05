/* response.vala
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

public class Pigeon.Response : Object {
    private Bytes response;
    private Soup.Session session;
    private Soup.Message message;

    public Response (
        Bytes response,
        Soup.Session session,
        Soup.Message message
    ) {
        this.response = response;
        this.session = session;
        this.message = message;
    }

    public Soup.MessageHeaders get_headers () {
        return message.response_headers;
    }

    public Bytes get_bytes () {
        return response;
    }
}
