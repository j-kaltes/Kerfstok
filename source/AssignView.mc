using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;

class AssignView extends WatchUi.View {
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
    var maxon=initer.memlab.size()-geg.from;
    if(geg.onscr<maxon) {
        maxon=geg.onscr;
        }
    for(var i=0;i<maxon;i++) {
        var val=geg.from+i;
//        if(val>= initer.memlab.size()) {return;}
            if(i==geg.assSelected) {
                dc.setColor(background,foreground);
                }
        dc.drawText(wmid, hmid*(i+1), Gfx.FONT_MEDIUM,initer.memlab[val],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
        if(i==geg.assSelected) {
              dc.setColor(foreground, background);
              }
        }
    }

}
