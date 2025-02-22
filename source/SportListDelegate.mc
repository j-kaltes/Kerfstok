using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Math;
using Toybox.Time;
class SportListDelegate extends WatchUi.BehaviorDelegate {
var view;
    function initialize(viewin) {
        BehaviorDelegate.initialize();
	view=viewin;
    }
    function onBack() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
 function onTap(clickEvent) {
        var co=clickEvent.getCoordinates();
	var id=co[1]*rows/height;
    	var it=view.start;
    	for(var i=0;i<id;i++) {
		it=nextsport[it];
		if(it==splen) {
			return true;
			}
		}

	tofront(it);

	sportdel.getsubsport();
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

 function onKey(keyEvent) {
 	if(alarmactive) {
		 stopalarm();
	 	}
 return true;
    }

    function onSwipe(swipe) {
		if(swipe.getDirection() == WatchUi.SWIPE_LEFT) {
        		return true;
		}
	return false;
    }
    function onPreviousPage() {
    	var start=view.start;
    	for(var i=0;i<rows;i++) {
		var tmpstart=prevsport[start];
		if(tmpstart==splen) {
			break;
			}
		start=tmpstart;
		}
	view.start=start;

	 WatchUi.requestUpdate();
        return true;
    }

    function onNextPage() {
    	if(view.iter<view.end) {
		view.start=view.iter;
		 WatchUi.requestUpdate();
		 }
	else {
		beep4();
		}
        return true;
	}
(:debug)    function onMenu() {
        return true;

    }
}
