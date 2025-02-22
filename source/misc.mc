
using Toybox.Attention;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.StringUtil;

function datestr( tim) {
var today = Gregorian.info(tim, Time.FORMAT_MEDIUM);
var dst =new[17];
dst[0]=(48+today.hour/10).toChar();
dst[1]=(48+today.hour%10).toChar();
dst[2]=':';

dst[3]=(48+today.min/10).toChar();
dst[4]=(48+today.min%10).toChar();
dst[5]=' ';
dst[6]=(48+today.day/10).toChar();
dst[7]=(48+today.day%10).toChar();
dst[8]='-';
var ar=today.month.toCharArray();
for(var i=0;i<3;i++) {
	dst[9+i]=ar[i];
	}
dst[12]='-';
for(var y=today.year,i=16;i>12;i--) {
	dst[i]=(48+(y%10)).toChar();
	y=y/10;
	}
return StringUtil.charArrayToString(dst); 
}

function beep1() {
if (Attention has :vibrate) {
    var vibeData =
    [
        new Attention.VibeProfile(100, 200), // On for two seconds
    ];
Attention.vibrate(vibeData);
	}
}
function beep4() {
	if (Attention has :vibrate) {
			var vibrateData = [
				new Attention.VibeProfile( 25, 66 ),
				new Attention.VibeProfile( 100, 66 ),
				new Attention.VibeProfile( 25, 66 )
			      ];

			Attention.vibrate(vibrateData);
		}
}
function beep2() {

	if (Attention has :vibrate) {
			var vibrateData = [
				new Attention.VibeProfile(  75, 50 ),
				new Attention.VibeProfile(  50, 50 ),
				new Attention.VibeProfile(  25, 50 ),
				new Attention.VibeProfile( 100, 50 )
			      ];

			Attention.vibrate(vibrateData);
		}
}
function beep3() {

	if (Attention has :vibrate) {
			var vibrateData = [
				new Attention.VibeProfile( 100, 50 ),
				new Attention.VibeProfile(  10, 50 ),
				new Attention.VibeProfile( 100, 50 ),
				new Attention.VibeProfile(  10, 50 ),
				new Attention.VibeProfile( 100, 50 )
			      ];

			Attention.vibrate(vibrateData);
		}
}

var  clearvibratedata=null;
function clearbeep() {
	if (Attention has :vibrate) {
		if(clearvibratedata==null) {
		  clearvibratedata = [
					new Attention.VibeProfile( 50, 100 ),
					new Attention.VibeProfile( 100, 500 ),
					new Attention.VibeProfile( 50, 50 ),
					new Attention.VibeProfile( 100, 1000 ),
					new Attention.VibeProfile( 50, 100 ),
					new Attention.VibeProfile( 100, 500 ),
					new Attention.VibeProfile( 50, 50 ),
					new Attention.VibeProfile( 100, 500 ),
				      ];

			}
		Attention.vibrate(clearvibratedata);
		}
	}
function generatealarm() {
	for(var i=0;i<6;++i) {
		clearbeep();
		if(!alarmactive) {
			return;
			}
		}
	}
function startalarm() {
	alarmactive=true;
	generatealarm();
	}
