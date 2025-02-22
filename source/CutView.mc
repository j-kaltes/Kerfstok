using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;

class CutView extends WatchUi.View {
var geg;
    function initialize(g) {
	geg=g;
        View.initialize();
    }



function onLayout(dc) {
}


    function onUpdate(dc) { 
	dc.clearClip();
	var wmid=width/2;
	var hmid=height/(geg.onscr+1);
	dc.setColor(foreground, background);
	 dc.clear();
var myTime = System.getClockTime(); // ClockTime object
	dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
	for(var i=0;i<geg.onscr;i++) {
		var val=geg.from+i;
		if(val<shortcuts.size()) {
			dc.drawText(wmid, hmid*(i+1), Gfx.FONT_MEDIUM,shortcuts[val][0],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
			}
		}
	}

}
