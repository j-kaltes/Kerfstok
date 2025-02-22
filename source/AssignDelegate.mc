using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;
import Toybox.Lang;

class AssignDelegate extends WatchUi.BehaviorDelegate {
var from=0;
var nums as number;
var onscr=4;
    function initialize(n as number) {
        BehaviorDelegate.initialize();
	nums=n;
    }
    function onBack() {
	       WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
 function onTap(clickEvent) {
if(clickEvent.getType()==CLICK_TYPE_TAP) { 
        var co=clickEvent.getCoordinates();
	var id=(onscr-(co[1]*onscr/height)-1) +from;
	if(id<memlab.size()) {	
		var was=numset.indexOf(id);
		if(nums.nums.size()) {
			if(was<0) {
				numset.add(id);
				}
			memnum[id]=[].addAll(nums.nums);
			}
		else {
			if(was>=0) {
				memnum[id]=[];
				}
		/*
			if(was>=0) {
				numset=numset.slice(0,was).addAll(numset.slice(was+1,numset.size()));
				}
				*/
			}
		}
       WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
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

    function onNextPage() {
	if(from<=0) {
       		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		return true;
		}
	from=from-onscr;
	 WatchUi.requestUpdate();
        return true;
    }

    function onPreviousPage() {
	var grens=memlab.size()-onscr;
	from=from<grens?from+onscr:from;
	 WatchUi.requestUpdate();
        return true;
	}
    function onMenu() {
        return true;
    }
}
