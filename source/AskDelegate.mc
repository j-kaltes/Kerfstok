using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;

class AskDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }
    function onBack() {
    	onResponse(false);
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
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

 function onKey(keyEvent) {
 	if(alarmactive) {
		 stopalarm();
	 	}
	 return true;
    }

    function onPreviousPage() {
        return true;
    }

    function onNextPage() {
        return true;
	}
    function onMenu() {
        return true;
    }


}
