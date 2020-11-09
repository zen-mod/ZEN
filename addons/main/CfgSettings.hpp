class CfgSettings {
    class CBA {
        class Versioning {
            class PREFIX {
                class dependencies {
                    CBA[] = {"cba_main", REQUIRED_CBA_VERSION, "(true)"};

                    // Warning for missing ACE compatibility PBO
                    ACE[] = {"zen_compat_ace", {VERSION_AR}, QUOTE(isClass (configFile >> 'CfgPatches' >> 'ace_main'))};
                };
            };
        };
    };
};
