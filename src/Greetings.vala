namespace Ensembles._Console {
    internal class Greeter : Object {
        public string app_version { get; set; }
        public string display_version { get; set; }

        public Greeter (string app_version, string display_version) {
            Object (
                app_version: app_version,
                display_version: display_version
            );
        }

        public void print_greetings () {
            print (Format.MAG);
            print ("███████ ███    ██ ███████ ███████ ███    ███ ██████  ██      ███████ ███████\n");
            print ("██      ████   ██ ██      ██      ████  ████ ██   ██ ██      ██      ██\n");
            print ("█████   ██ ██  ██ ███████ █████   ██ ████ ██ ██████  ██      █████   ███████\n");
            print ("██      ██  ██ ██      ██ ██      ██  ██  ██ ██   ██ ██      ██           ██\n");
            print ("███████ ██   ████ ███████ ███████ ██      ██ ██████  ███████ ███████ ███████\n");
            print (Format.RED);
            print ("============================================================================\n");
            print (Format.YEL);
            print ("%s: %s, %s: %s   |   (c) %s %s\n",
            _("VERSION"),
            app_version,
            _("DISPLAY VERSION"),
            display_version,
            "SUBHADEEP JASU",
            "2020 - 2023");
            print (Format.RED);
            print ("----------------------------------------------------------------------------\n");
            print (Format.RESET);
        }
    }
}
