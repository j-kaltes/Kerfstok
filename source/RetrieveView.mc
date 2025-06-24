using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;

class RetrieveView extends WatchUi.View {
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
    //dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
    dc.setColor(foreground, background);
     dc.clear();
var myTime = System.getClockTime(); // ClockTime object
    dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
    var maxon=numset.size()-geg.from;
    if(geg.onscr<maxon) {
            maxon=geg.onscr;
            }
    for(var i=0;i<maxon;i++) {
        var val=geg.from+i;
        if(i==selected) {
            dc.setColor(background,foreground);
            }
        dc.drawText(wmid, hmid*(i+1), Gfx.FONT_MEDIUM,initer.memlab[numset[val]],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
        if(i==selected) {
              dc.setColor(foreground, background);
              }
        }
    }

}
