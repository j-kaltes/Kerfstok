using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Application.Storage;
var clockhight;
//const clockfont= Gfx.FONT_XTINY;
var clockfont;
class VarView extends WatchUi.View {
var hmid;
//const clockfont= Gfx.FONT_LARGE;
//const clockfont= Gfx.FONT_MEDIUM;
    function initialize() {
        View.initialize();
	from=0;
	hmid=height/(onscr+1);
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
	for(var i=0;i<onscr;i++) {
		var val=from+i;
		if(val<varnr) {
			dc.drawText(wmid, hmid*(i+1), Gfx.FONT_MEDIUM,vars[val],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
			}
		}
	}

}
