using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Application.Storage;
class SportStartView extends WatchUi.View {
var hmid;
    function initialize() {
        View.initialize();
     hmid=height/5;
    }

function onShow() {
}
var first=true;
function onLayout(dc) {
}
function onHide() {
    sportsave();
    }

function showitem(dc,pos,str) {
    var pos1=pos-1;
    if(sportStartSel==pos1) {
        dc.setColor( background,foreground);
        }
    dc.drawText(wmid, hmid*pos, Gfx.FONT_TINY,str,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
    dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
    }
function onUpdate(dc) { 
    dc.clearClip();
    dc.setColor(foreground, background);
    dc.clear();
    dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
    var myTime = System.getClockTime(); // ClockTime object
    dc.drawText(wmid, clocky, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );

    var val=nextsport[splen];
    var spo=sports[val];
    if(sportdel.subsport>=0) {
        var    sub=spo[1][sportdel.subsport];
        showitem(dc,3,subsportstr[sub]);
        }
    var laplen=sportdel.laplen;
    var lstr=(laplen==0.0)?"no autolap":(laplen*toshowdistance).format("%.1f")+" "+initer.distanceunits+" laps";
    showitem(dc,1,lstr);
//    dc.drawText(wmid, hmid, Gfx.FONT_TINY,lstr,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );

    var unixnu=Time.now().value();
    var vers=unixnu-glucosetime;
    if(vers<maxver) {
         dc.drawText(0,height*.5, Gfx.FONT_XTINY ,glucosestr+(glucoserate==-20?">":glucoserate==20?"<":""),Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT);

        }

    showitem(dc,2,spo[0]);
//    dc.drawText(wmid, 2*hmid, Gfx.FONT_TINY,spo[0],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );

    if(locinfo!=null) {
        dc.drawText(width*0.3, 4*hmid+10, clockfont,  "GPS",Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_RIGHT );
        if(first) {
            beep2();
            first=false;
            }
        }
    if(sportStartSel==3) {
            dc.setColor( background,foreground);
            }
    dc.drawText(width*.6, 4*hmid+10, Gfx.FONT_TINY ,"Start",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT);
    }

}
