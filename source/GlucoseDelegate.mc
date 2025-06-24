using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Math;
using Toybox.Time;
using Toybox.ActivityRecording;
using Toybox.Lang;

class StopSportConfirmationDelegate extends AskDelegate {
    function initialize() {
        AskDelegate.initialize();
    }

    function onResponse(response) {
        if(response) {
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
//    var val=501.0;
    var dir=Math.pow(-1,(Math.rand()%2));
    var dirval=Math.rand()%5;
    var trend= dir*dirval;
    var gegs=["3MH0045FKCD",unixnu, val,trend,0,unit];
    unititer++;
    setglucose(gegs);
    }
(:release) 
function mkglucose() {
    }

 function       switchcolor() {
        if(currentcolor==1) {
                setcolor(0);
                }
         else {
                setcolor(1);
                }
        }
public function askstopsport() as Lang.Boolean {
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
function onHold(clickEvent) {
        switchcolor();
        return true;
        }
 function onKey(evt) {
    if(alarmactive) {
        stopalarm();
        }
    else {
       var key=evt.getKey();
       switch(key) {
        case Toybox.WatchUi.KEY_DOWN: {
            mkglucose();
            break;
            }
        case Toybox.WatchUi.KEY_UP: {
                switchcolor();
                break;
                }
        default: {
            askstopsport();
             }
           }
        }
        return true;

    }
    function onSwipe(swipe) {
    return false;
    }
}
