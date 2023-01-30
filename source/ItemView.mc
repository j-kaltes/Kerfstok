using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;
class ItemView extends WatchUi.View {
var hmid;
var val;
    function initialize(valin) {
        View.initialize();
    	val=valin;

	 hmid=height/5;
    }
/*
 function onLayout(dc) {
   }
*/
//function onShow() {
 //   }



    function onUpdate(dc) { 
	dc.clearClip();
	dc.setColor(foreground, background);
	dc.clear();
var myTime = System.getClockTime(); // ClockTime object
	dc.drawText(wmid,clockhight , clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
	var tim = Gregorian.info(new Time.Moment(val[0]) , Time.FORMAT_MEDIUM);
	dc.drawText(wmid*2/3, hmid, Gfx.FONT_MEDIUM,tim.hour.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT );
	dc.drawText(wmid, hmid, Gfx.FONT_MEDIUM,":",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
	dc.drawText(wmid*4/3, hmid, Gfx.FONT_MEDIUM,tim.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT );

	dc.drawText(wmid/2, 2*hmid, Gfx.FONT_TINY,tim.day,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT );
	dc.drawText(wmid, 2*hmid, Gfx.FONT_TINY,tim.month,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
	dc.drawText(wmid*3/2, 2*hmid, Gfx.FONT_TINY,tim.year,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT );

	dc.drawText(wmid/10, 3*hmid, Gfx.FONT_TINY,vars[val[2]],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT );

	dc.drawText(wmid*19/10, 3*hmid, Gfx.FONT_TINY ,val[1].format("%g"),Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT );

	dc.setColor(background, foreground);
	dc.drawText(wmid*2/3, 4*hmid+10, Gfx.FONT_TINY ,"Del",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER);
	dc.drawText(wmid*4/3, 4*hmid+10, Gfx.FONT_TINY ,"Save",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER);
	}
}
