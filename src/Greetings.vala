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
            print (_("VERSION: %s, DISPLAY VERSION: %s   |   (c) SUBHADEEP JASU 2020 - 2023\n"),
             app_version, display_version);
            print (Format.RED);
            print ("----------------------------------------------------------------------------\n");
            print (Format.RESET);
        }
    }
}
