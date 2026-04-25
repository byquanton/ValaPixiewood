/* window.vala
 *
 * Copyright 2026 byquanton
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
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public errordomain MessageError {
    FAILED;
}

private const string IMAGE_URL = "https://picsum.photos/800";

[GtkTemplate (ui = "/eu/byquanton/valapixiewood/window.ui")]
public class Valapixiewood.Window : Adw.ApplicationWindow {

    [GtkChild]
    private unowned Gtk.Picture picture;

    public Window (Gtk.Application app) {
        Object (application: app);

        load_image.begin ();
    }

    private async void load_image () {
        try {
            Bytes image_bytes = yield get_image_bytes (IMAGE_URL);
            picture.paintable = Gdk.Texture.from_bytes (image_bytes);
        } catch (Error e) {
            critical (e.message);
        }
    }

    private async Bytes get_image_bytes (string url) throws Error {
        var session = new Soup.Session ();
        var message = new Soup.Message.from_uri ("GET", Uri.parse (url, UriFlags.NONE));

        Bytes image_bytes = yield session.send_and_read_async (
            message,
            Priority.DEFAULT,
            null
        );

        Soup.Status status = message.get_status ();
        string reason = message.reason_phrase;

        if (status != Soup.Status.OK) {
            throw new MessageError.FAILED (@"Got $status: $reason");
        }

        return image_bytes;
    }
}