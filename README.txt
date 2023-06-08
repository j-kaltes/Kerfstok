
Kerstok is watch app for certain Garmin with touchscreen. It can be downloaded from: https://apps.garmin.com/es-ES/apps/b6348ccc-86d8-4780-8013-d9e19fed5260

It should be used with Juggluco, https://www.juggluco.nl/Juggluco/index.html

With it, you can enter numbers under a certain label on your watch. These numbers are sent to Juggluco.
If you have a Freestyle Libre 2 sensor in you arm, Kerfstok can also display your current glucose value on your watch. The FreeStyle Libre 2 sensor sends via Bluetooth every minute the glucose level to Juggluco running on Android and Juggluco sends this to Kerfstok on a Garmin watch also via Bluetooth.

I published the source of Kerfstok so people can modify it to fit their taste.

For more information about Juggluco visit:

https://www.juggluco.nl/Juggluco/index.html

For more information about Kerfstok, see:

https://www.juggluco.nl/Kerfstok/index.html

For information about how to build a Garmin watch app, see:
https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/#gettingstarted

To build the app you need to turn off type checkings: 
- When using Eclipse, you have to put  -l 0
in Windows->Preferences->ConnectIQ->Compiler->"Compiler time options". See: 
https://forums.garmin.com/developer/connect-iq/f/discussion/314861/sdk-4-1-6-generating-new-errors-and-warnings
- In Visual Studio Code, you have to go to the Extensions (View->Extensions), Press on the cog symbol beside Monkey, select "Extension settings" and set "Type Check Level" to off. 

Jaap Korthals Altes
