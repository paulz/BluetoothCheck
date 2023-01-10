# BluetoothCheck
Command line utility to check if Bluetooth device is on and available

Example of usage:

```
open -W -o /tmp/check-mydevice.txt \
    /Applications/BluetoothCheckLauncher.app \
    --args 48C80007-F448-4193-82FF-87CC231BE38A
```

and if device with Bluetooth Service 48C80007-F448-4193-82FF-87CC231BE38A found within 10 seconds /tmp/check-mydevice.txt will have name and signal strength:

