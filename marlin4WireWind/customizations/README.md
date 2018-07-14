
# Customizations:

## RepRapDiscount Full Graphic Smart Controller
We used this 12864 "RepRapDiscount Full Graphic Smart Controller":
 - uncomment `#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER`
 - Install u8glib into Arduino/Library:
```
$ install_u8glib.sh
```

## Install Custom Bootscreen:
- uncomment #define SHOW_CUSTOM_BOOTSCREEN and recompile
```
$ cp _Bootscreen.h ../Marlin
```

