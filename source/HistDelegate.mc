using Toybox.WatchUi;
//using Toybox.Graphics as Gfx;
//using Toybox.System;
//using Toybox.Math;
using Toybox.Time;
using Toybox.Time.Gregorian;
class HistDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }
    function onBack() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	return true;
    }
    function onSwipe(swipe) {
	if(swipe.getDirection() == WatchUi.SWIPE_LEFT) {
        	return dayback() ;
		}
	return false;
	}
 function onTap(clickEvent) {
        var co=clickEvent.getCoordinates();
	var id=co[1]*histrows/height;

	if(id<maxshown) {
		var toonid= shown[id];
		var base=shownbase[id];
		var val=getval(base,toonid);
		if(val) {
			WatchUi.pushView(new ItemView(val), new ItemDelegate(base,toonid,val),WatchUi.SLIDE_IMMEDIATE) ;
			}
		else {
			}
		}
		return true;
    }
function dayback() {
	if(item0>minimum[0]||item1>minimum[1]) {
		var nday=1893452400;
		for(var i=histrows-1;i>=0;i--) {
			var val=getval(shownbase[i],shown[i]);		
			if(val!=null) {
				nday=val[0]-60*60*23;
				break;
				}
			}

		showiter0=item0;showiter1=item1;
		for(;showiter0>=minimum[0];showiter0--) {
			var val0=getval(0,showiter0);
			if(val0!=null&&val0[0]<nday) {
				break;
				}
			}
		for(;showiter1>=minimum[1];showiter1--) {
			var val1=getval(1,showiter1);
			if(val1!=null&&val1[0]<nday) {
				break;
				}
			}
		WatchUi.requestUpdate();
		return true;
		}
		return false;
	}
 function onKey(keyEvent) {
 	if(alarmactive) {
		 stopalarm();
	 	}
	else {
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		}
 	return true;
    }

function onPreviousPage() {
	var it0=showiter0+1;	
	var it1=showiter1+1;
	for(var i=0;i<histrows&&(it0<storageid[0]||it1<storageid[1]);i++) {	
		var tim0=1893452400,tim1=1893452400;
		while(it0<storageid[0])	{
			var val=getval(0,it0);
			if(val!=null) {
				tim0=val[0];		
				break;
				}
			it0++;
			}
		while(it1<storageid[1])	{
			var val=getval(1,it1);
			if(val!=null) {
				tim1=val[0];		
				break;
				}
			it1++;
			}
		if(tim0<tim1) {	
			it0++;
			}
		else {
			if(it1<storageid[1]) {
				it1++;
				}
			else {
				break;
				}
			}

		}
	showiter0=it0-1;
	showiter1=it1-1;
	WatchUi.requestUpdate();
        return true;
}


function onNextPage() {
	if(item0<minimum[0]&&item1<minimum[1]) {
		beep1();
		return false;
		}
	showiter0=item0;
	showiter1=item1;
	WatchUi.requestUpdate();
	return true;
    }


}
