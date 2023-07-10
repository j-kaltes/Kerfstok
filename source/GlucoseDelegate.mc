using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Math;
using Toybox.Time;
using Toybox.ActivityRecording;

class StopSportConfirmationDelegate extends AskDelegate {
    function initialize() {
        AskDelegate.initialize();
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_YES) {
		sportdel.stopsport();
		sportdel=null;
		}
	else {
		activityrecord.start();
		}
    }
}

var glufield=null;
var activityrecord=null;
var sportdel=null;
(:debug)
	var unititer=0;
(:debug) 
function mkglucose() {
	var unixnu=Time.now().value();
	var unit=unititer%2;
	var val=(Math.rand()%460+40)/(1+unit*17);
//	var val=501.0;
	var dir=Math.pow(-1,(Math.rand()%2));
	var dirval=Math.rand()%5;
	var trend= dir*dirval;
	var gegs=["3MH0045FKCD",unixnu, val,trend,0,unit];
	System.println("dir="+dir+" dirval="+dirval+" trend="+trend);
	unititer++;
	setglucose(gegs);
	}

function askstopsport() {
         if( activityrecord != null  &&activityrecord.isRecording() == true ) {
	 	activityrecord.stop();
		if(sportdel!=null) {
			WatchUi.pushView(new AskView("Paused","Stop "+sports[nextsport[splen]][0]+"?"), new StopSportConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
			}
		return true;
		}
	return false;	
	}
class GlucoseDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }
    function onBack() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
(:debug) 
 function onTap(clickEvent) {
 	mkglucose();
        return true;
    }
 function onKey(keyEvent) {
	if(alarmactive) {
		stopalarm();
		}
	else {
		askstopsport();
		}
        return true;

    }
    function onSwipe(swipe) {
	return false;
    }
    function onPreviousPage() {
        return true;
    }

    function onNextPage() {
        return true;
	}
}
