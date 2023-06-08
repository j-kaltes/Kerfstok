using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

class AskView extends WatchUi.View {
var comments;
var question;
    function initialize(c,q) {
        View.initialize();
	comments=c;
	question=q;
    }


function onLayout(dc) { }
    function onUpdate(dc) { 
	dc.clearClip();
	dc.setColor(foreground, background);
	 dc.clear();
	var unixnu=Time.now().value();
	var myTime = Gregorian.info(new Time.Moment(unixnu) , Time.FORMAT_MEDIUM);
	dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );

	var vers=unixnu-glucosetime;
	
	dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
	if(vers<maxver) {
	 	dc.drawText(width*.95,height*.35, Gfx.FONT_XTINY ,glucosestr+(glucoserate==-20?">":glucoserate==20?"<":""),Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT);
		}
	dc.drawText(wmid,height*.20,Gfx.FONT_LARGE,comments, Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER);
	dc.drawText(wmid,height*.5,Gfx.FONT_LARGE,question,  Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER);

	dc.drawText(width*.4,height*.8,Gfx.FONT_LARGE,"No",  Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_RIGHT);
	dc.drawText(width*.6,height*.8,Gfx.FONT_LARGE,"Yes",  Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_LEFT);
	}

}
