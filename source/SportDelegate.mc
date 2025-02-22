using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Math;
using Toybox.Time;
using Toybox.ActivityRecording;


class SportDelegate extends WatchUi.BehaviorDelegate {
var sportview;
    function initialize(spo) {
	sportview=spo;
        BehaviorDelegate.initialize();
    }
    function onBack() {
    	measure=null;
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
var notlong=0;
var manuallap=0;
function manualtap(unixnu) {
	if(activityrecord!=null&&activityrecord.addLap()) {
		beep3();
		++manuallap;
		lapstr1="M "+ manuallap;
		mklapstr(unixnu-lapstart);
		lapstart=unixnu;
		endlap=unixnu+10;
		WatchUi.requestUpdate();
		}
	}
function onMenu() {
	manualtap(Time.now().value());
	return true;

}
 function onTap(clickEvent) {
	var unixnu=Time.now().value();
	if(unixnu<notlong) {
		manualtap(unixnu);
		notlong=0;
		}
	else {
		notlong=unixnu+2;
		}
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
	if(measure==null) {
		beep4();
		return true;
		}
        if(measure.start<0) {
		measure=null;
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		WatchUi.requestUpdate();
		return true;
		}
	var it=measure.start;
//	var actinfo=	Activity.getActivityInfo();
	for(var i=0;i<rows;i++) {
		var res;
		 do {
			 if(it<0) {
			 	if(i==0) {
					beep4();
					}
				else  {
				    measure.start=it;
					WatchUi.requestUpdate();
			    	}
				return true;
			    }
			 res=infofunc(actinfo,it);
			 it--;
			 } while(res==null);
		}
	 measure.start=it;
	WatchUi.requestUpdate();
        return true;
    }
var measure=null;
    function onNextPage() {
    	if(measure==null)	 {
		measure=new MeasureView();
		WatchUi.pushView( measure, self, WatchUi.SLIDE_IMMEDIATE);
		return true;
		}
	else {
		if(measure.iter>=(infostr.size()-1)) {
			beep4();
			return true;
			}
		}
	measure.start=measure.iter;
	WatchUi.requestUpdate();
        return true;
	}
}
