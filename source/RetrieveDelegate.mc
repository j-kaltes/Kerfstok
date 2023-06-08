using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;

var numset=[];
class RetrieveDelegate extends WatchUi.BehaviorDelegate {
var from;
var nums;
var onscr=4;
    function initialize(n) {
	nums=n;
	if(numset.size()<1) {from=0;} else {
		from=((numset.size()-1)/onscr)*onscr;
			}
        BehaviorDelegate.initialize();
    }
    function onBack() {
	       WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
 function onTap(clickEvent) {
if(clickEvent.getType()==CLICK_TYPE_TAP) { 
        var co=clickEvent.getCoordinates();
	var id=co[1]*onscr/height+from;
//	var id=(onscr-(co[1]*onscr/height)-1) +from;
	if(id<numset.size()) {
		fromback=false;
		nums.nums.addAll(memnum[numset[id]]);
	       WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		}
	else {
		beep4();
		}
        return true;
	}
return false;
    }

 function onKey(keyEvent) {
 	if(alarmactive) {
		 stopalarm();
	 	}
 return true;
    }

    function onPreviousPage() {
	from=(from<onscr)?0:from-onscr;
	 WatchUi.requestUpdate();
        return true;
    }

    function onNextPage() {
	var grens=numset.size()-onscr;
	if(from>=grens) {
	       WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	       return true;
		}
	from=from+onscr;
	 WatchUi.requestUpdate();
        return true;
	}
    function onMenu() {
        return true;
    }
}
