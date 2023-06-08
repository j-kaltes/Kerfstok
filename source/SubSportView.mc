using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Application.Storage;
class SubSportView extends WatchUi.View {
var hmid;
//const clockfont= Gfx.FONT_LARGE;
//const clockfont= Gfx.FONT_MEDIUM;
var subs;
var from;
    function initialize(subsin,fromin) {
        View.initialize();
	subs=subsin;
	from=fromin;
	hmid=height/(rows+1);
    }

function onShow() {
}
function onLayout(dc) {
	clockhight= dc.getFontHeight(clockfont)/3;
}


    function onUpdate(dc) { 
	dc.clearClip();
	dc.setColor(foreground, background);
	 dc.clear();
	var myTime = System.getClockTime(); // ClockTime object
	dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
	for(var i=0;i<rows;i++) {
		var val=from+i;
		if(val>=subs.size()) {
			break;
			}
		var su=subs[val];
		dc.drawText(wmid, hmid*(i+1), Gfx.FONT_MEDIUM,subsportstr[su],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
		}
	}

}

class SubSportDelegate extends WatchUi.BehaviorDelegate {
var view;
//var sportkey;
    function initialize(viewin) {
        BehaviorDelegate.initialize();
	view=viewin;
//	sportkey=sportin;
    }
    function onBack() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
 function onTap(clickEvent) {
        var co=clickEvent.getCoordinates();
	var id=co[1]*rows/height+view.from;
	if(id<view.subs.size()) {
		sportdel.setsubsport(id);
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		}
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
    	if(view.from>0)  {
		view.from-=rows;
	 	WatchUi.requestUpdate();
		}
	else {
		beep4();
		}
        return true;
    }

    function onNextPage() {
    	var next=view.from+rows;
    	if(next<view.subs.size()) {
		view.from=next;
	 	WatchUi.requestUpdate();
		}
	else {
		beep4();
		}
        return true;
	}
}
