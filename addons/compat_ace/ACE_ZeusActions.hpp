class ACE_ZeusActions {
    class ZeusUnits {
        class remoteControl {
            condition = QUOTE(call FUNC(canRemoteControl));
            statement = QUOTE(call FUNC(remoteControl));
        };
    };
};
