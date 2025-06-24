using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;
import Toybox.Lang;
class AskDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }
public function onResponse(response as  Boolean) as Void { }
 function onTap(clickEvent) {
	if(clickEvent.getType() == CLICK_TYPE_TAP ) { 
		var co=clickEvent.getCoordinates();
		var y=co[1];
		var x=co[0];
		if(y*2>height) {	
			onResponse(x*2>width);
			WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
			}
	}
        return true;
    }

 function onKey(evt) {
 	if(alarmactive) {
		 stopalarm();
	 	}
     else {
       var key=evt.getKey();
       switch(key) { 
            case Toybox.WatchUi.KEY_ENTER:  {
    	        onResponse(true);
	            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                break;
                }
            case Toybox.WatchUi.KEY_ESC:  {
    	        onResponse(false);
	            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                break;
                }
            default: beep4();
            }
       }
	 return true;
    }

    function onMenu() {
        return true;
    }


}
