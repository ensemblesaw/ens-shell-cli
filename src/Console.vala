/*
 * Copyright 2020-2023 Subhadeep Jasu <subhadeep107@proton.me>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Ensembles._Console;

namespace Ensembles {
    public class Console {
        public static bool verbose = false;
        public static bool console_initialized = false;
        public static string domain = "";

        public enum LogLevel {
            SUCCESS,
            TRACE,
            WARNING,
            ERROR,
        }

        private static void init () {
            if (!console_initialized) {
                console_initialized = true;

                Intl.setlocale (LocaleCategory.ALL, "");
                Log.set_default_handler (log_handler);
            }
        }

        /**
         * Show the app greetings message with copyright notice.
         *
         * @param app_version release version of the app
         * @param display_version friendly version of the app
         */
        public static void greet (string app_version, string display_version) {
            init ();
            new Greeter (app_version, display_version).print_greetings ();
        }

        /**
         * Log a message to console of type `T`.
         *
         * @param object the object could be a string, error or a `Printable`
         * @param log_level the `LogLevel` which the log should be of
         * @param line the line number from where `log` is called. use `Log.LINE`
         * @param function_name the function which calls `log`. Use `Log.METHOD`
         * @param file_name the file where `log` is called. Use `Log.FILE`
         */
        public static void log<T> (
            T object,
            LogLevel log_level = LogLevel.TRACE,
            int? line = 0,
            string? function_name = Log.METHOD,
            string? file_name = Log.FILE
        ) {
            var _verbose = verbose || Log.get_debug_enabled () || Environment.get_variable ("G_MESSAGES_DEBUG") == "all";

            // If the log level is not TRACE or WARNING and verbose if off, then donot print
            if (!_verbose && (log_level == LogLevel.TRACE || log_level == LogLevel.WARNING)) {
                return;
            }

            init ();
            DateTime date_time = new DateTime.now_local ();
            string message = "";
            if (typeof (T) == Type.STRING) {
                message = (string) object;
            } else if (typeof (T) == typeof (Error)) {
                message = ((Error) object).domain.to_string ()
                .replace ("-quark", "")
                .replace ("-", " ")
                .up ();
                message += ": " + ((Error) object).message;
            } else if (object is Printable) {
                message = ((Printable) object).to_string();
            }

            string log_message = "";

            if (_verbose) {
                log_message += "%s[%s%d:%2d:%2d %3d%s] ".printf (
                    Format.RESET,
                    Format.BLU,
                    date_time.get_hour (),
                    date_time.get_minute (),
                    date_time.get_second (),
                    date_time.get_microsecond (),
                    Format.RESET
                );
            }

            switch (log_level) {
                case SUCCESS:
                log_message = "%s▎%s%sSUCCESS %s".printf (Format.GRN, Format.WHT, Format.BOLD, Format.RESET) + log_message;
                break;
                case TRACE:
                log_message = "%s▎%s%sTRACE   %s".printf (Format.CYN, Format.WHT, Format.BOLD, Format.RESET) + log_message;
                break;
                case WARNING:
                log_message = "%s▎%s%sWARNING %s".printf (Format.YEL, Format.WHT, Format.BOLD, Format.RESET) + log_message;
                break;
                case ERROR:
                log_message = "%s▎%s%sERROR   %s".printf (Format.RED, Format.WHT, Format.BOLD, Format.RESET) + log_message;
                break;
            }

            if (line > 0) {
                if (_verbose) {
                    switch (log_level) {
                        case ERROR:
                        log_message += "<File \"%s\", line %s%d%s, in %s%s ()%s>:\n    %s%s%s\n".printf (
                            file_name,
                            Format.MAG,
                            line,
                            Format.RESET,
                            Format.BOLD,
                            function_name,
                            Format.RESET,
                            Format.RED,
                            message,
                            Format.RESET
                        );
                        stderr.printf (log_message);
                        break;
                        case WARNING:
                        log_message += "<File \"%s\", line %s%d%s>: %s%s%s\n".printf (
                            file_name,
                            Format.MAG,
                            line,
                            Format.RESET,
                            Format.YEL,
                            message,
                            Format.RESET
                        );
                        stdout.printf (log_message);
                        break;
                        default:
                        log_message += message + "\n";
                        stdout.printf (log_message);
                        break;
                    }
                } else {
                    log_message += message + "\n";
                    stdout.printf (log_message);
                }
            } else {
                switch (log_level) {
                    case ERROR:
                    log_message += ": %s%s%s\n".printf (Format.RED, message, Format.RESET);
                    stderr.printf (log_message);
                    break;
                    case WARNING:
                    log_message += ": %s%s%s\n".printf (Format.YEL, message, Format.RESET);
                    stderr.printf (log_message);
                    break;
                    default:
                    log_message += ": %s%s%s\n".printf (Format.WHT, message, Format.RESET);
                    stdout.printf (log_message);
                    break;
                }
            }

            if (log_level == LogLevel.ERROR) {
                breakpoint ();
            }
        }

        private static void log_handler (string? log_domain, LogLevelFlags log_level, string message) {
            var custom_log_level = LogLevel.TRACE;
            switch (log_level) {
                case FLAG_FATAL:
                case FLAG_RECURSION:
                case LEVEL_ERROR:
                custom_log_level = LogLevel.ERROR;
                break;
                case LogLevelFlags.LEVEL_CRITICAL:
                case LogLevelFlags.LEVEL_WARNING:
                custom_log_level = LogLevel.WARNING;
                break;
                default:
                custom_log_level = LogLevel.TRACE;
                break;
            }

            log (message, custom_log_level, 0);
        }
    }
}
