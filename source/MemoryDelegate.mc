using Toybox.WatchUi;
using Toybox.Lang;
using Toybox.System;

class MemoryDelegate extends WatchUi.BehaviorDelegate {
//var selectableMode = false;
var gegs,nums;
    function initialize(g,n) {
	gegs=g;
	nums=n;
        BehaviorDelegate.initialize();
    }
    function onBack() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

 function onTap(clickEvent) {
if(clickEvent.getType() == CLICK_TYPE_TAP ) { 
        var co=clickEvent.getCoordinates();
	var id=co[1]*gegs.pos.size()/height;
	var x=co[0]*gegs.pos[id]/width;
	var	p=gegs.startpos;
	for(var i=0;i<id;i++)	{
		p+=gegs.pos[i];
		}
	p+=x;
	if(p<gegs.previous.size()) {
		fromback=false;
		nums.nums.addAll(gegs.previous[p].toCharArray());
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
    	if(gegs.startpos>0) {
		gegs.startpos-=gegs.onscreen;
		if(gegs.startpos<0) {
			gegs.startpos=0;
			}
		WatchUi.requestUpdate();
		}
        return true;
	}
function onNextPage() {
	gegs.startpos+=gegs.onscreen;
    	if(gegs.startpos>=gegs.previous.size()) {
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		}
	else {
		WatchUi.requestUpdate();
		}
	return true;
    }

    function onMenu() {
// selectableMode = !selectableMode;
//	gegs.setKeyToSelectableInteraction(selectableMode);
        return true;
    }



}


