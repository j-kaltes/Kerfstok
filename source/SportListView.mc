using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Application.Storage;
var rows=4;
class SportListView extends WatchUi.View {
var hmid;
var  start,end,iter;
    function initialize(startin,endin) {
        View.initialize();
	start=startin;
	end=endin;
	hmid=height/(rows+1);
    }

function onShow() {
}
function onLayout(dc) {
}


    function onUpdate(dc) { 
	dc.clearClip();
	dc.setColor(foreground, background);
	 dc.clear();
	var myTime = System.getClockTime(); // ClockTime object
	dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
	iter=start;
	for(var i=0;i<rows;i++) {
		if(iter>=end) {
			break;
			}
		dc.drawText(wmid, hmid*(i+1), Gfx.FONT_XTINY,sports[iter][0],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
		iter=nextsport[iter];
		}
	}

}
