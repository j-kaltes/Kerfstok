
Kerstok is watch app for certain Garmin with touchscreen. It can be downloaded from: https://apps.garmin.com/es-ES/apps/b6348ccc-86d8-4780-8013-d9e19fed5260

It should be used with Juggluco, https://play.google.com/store/apps/details?id=tk.glucodata

With it, you can enter numbers under a certain label on your watch. These numbers are sent to Juggluco.
If you have a Freestyle Libre 2 sensor in you arm, Kerfstok can also display your current glucose value on your watch. The FreeStyle Libre 2 sensor sends via Bluetooth every minute the glucose level to Juggluco running on Android and Juggluco sends this to Kerfstok on a Garmin watch also via Bluetooth.

I published the source of Kerfstok so people can modify it to fit their taste.

For more information about Juggluco visit:

http://jkaltes.byethost16.com/Juggluco/index.html

For more information about Kerfstok, see:

http://jkaltes.byethost16.com/Kerfstok/index.html

For information about how to build a Garmin watch app, see:
https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/#gettingstarted

To build the app you need to turn off type checkings: when using Eclipse, you have to put  -l 0
in Windows->Preferences->ConnectIQ->Compiler->"Compiler time options". See: 
https://forums.garmin.com/developer/connect-iq/f/discussion/314861/sdk-4-1-6-generating-new-errors-and-warnings


Jaap Korthals Altes
