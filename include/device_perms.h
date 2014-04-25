#define CONTROL_PERMS_APPEND \
    { "rawip_vsnet1", AID_RADIO, AID_RADIO }, \
    { "rawip_vsnet2", AID_RADIO, AID_RADIO }, \
    { "rawip_vsnet3", AID_RADIO, AID_RADIO }, \
    { "rawip_vsnet4", AID_RADIO, AID_RADIO }, \
    { "vsnet1_down",  AID_RADIO, AID_RADIO }, \
    { "vsnet2_down",  AID_RADIO, AID_RADIO },

#define PROPERTY_PERMS_APPEND \
    { "service.",         AID_RADIO,    0 }, \
    { "watchdog.reset_progress",      AID_RADIO,    AID_RADIO }, \
    { "media.tegra",      AID_MEDIA,    0 }, \
    { "nvidia.", AID_SYSTEM, 0 },
