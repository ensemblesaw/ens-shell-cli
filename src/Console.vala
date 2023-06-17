/*
 * Copyright 2020-2023 Subhadeep Jasu <subhadeep107@proton.me>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Ensembles._Console;

namespace Ensembles {
    public class Console {
        public static bool verbose = true;
        public static string domain = "";

        public enum LogLevel {
            SUCCESS,
            TRACE,
            WARNING,
            ERROR,
        }

        public void greet (string app_version, string display_version) {
            new Greeter (app_version, display_version).print_greetings ();
        }

        public void log<T> (T object, LogLevel log_level = LogLevel.TRACE) {
            DateTime date_time = new DateTime.now_utc ();
            string message = "";
            if (typeof (T) == Type.STRING) {
                message = (string) object;
            } else if (typeof (T) == typeof (Error)) {
                message = ((Error) object).domain.to_string ()
                .replace ("-quark", "")
                .replace ("-", " ")
                .up ();
                message += ": " + ((Error) object).message;
            }

            switch (log_level) {
                case SUCCESS:
                if (verbose) {
                    print ("%s▎%s%sSUCCESS %s[%s%s%s]: %s\n", Format.GRN, Format.WHT, Format.BOLD,
                        Format.RESET, Format.BLU, date_time.to_string (), Format.RESET, message);
                }
                break;
                case TRACE:
                if (verbose) {
                    print ("%s▎%s%sTRACE   %s[%s%s%s]: %s\n", Format.CYN, Format.WHT, Format.BOLD, Format.RESET, Format.BLU, date_time.to_string (),
                        Format.RESET, message);
                }
                break;
                case WARNING:
                if (verbose) {
                    print ("%s▎%s%sWARNING %s[%s%s%s]: %s%s%s\n", Format.YEL, Format.WHT, Format.BOLD, Format.RESET, Format.BLU, date_time.to_string (),
                        Format.RESET, Format.YEL, message, Format.RESET);
                }
                break;
                case ERROR:
                print ("%s▎%s%sERROR %s[%s%s%s]: %s%s%s\n", Format.RED, Format.WHT, Format.BOLD, Format.RESET, Format.BLU, date_time.to_string (),
                    Format.RESET, Format.RED, message, Format.RESET);
                GLib.log (domain, LogLevelFlags.LEVEL_ERROR, message);
                break;
            }
        }
    }
}
