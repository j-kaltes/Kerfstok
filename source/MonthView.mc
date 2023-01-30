using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Math;
using Toybox.Time;
using Toybox.Time.Gregorian;

var months;
function getmonths() {
var options = {
    :year   => 2020,
    :month  => 1, 
    :day    => 4,
    :hour   => 0
};
months=new[12];
for(var i=0;i<12;i++) {
	options[:month]=i+1;
	var date = Gregorian.moment(options);
	var da = Gregorian.info(date, Time.FORMAT_MEDIUM);
	months[i]=da.month;
	}
}


class MonthView extends WatchUi.View {
const monthfont= venusq2?Gfx.FONT_SMALL:Gfx.FONT_MEDIUM;
    function initialize() {

        View.initialize();

    }

 function onLayout(dc) {
   }

//function onShow() {
 //   }



    function onUpdate(dc) { 
	dc.clearClip();
	dc.setColor(foreground, background);
	dc.clear();
	dc.setColor(foreground, Graphics.COLOR_TRANSPARENT );
var myTime = System.getClockTime(); // ClockTime object
	dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
	var fw=dc.getTextWidthInPixels(months[0], monthfont);
	var r=width/2 - fw*4/5;
	var incr=Math.PI/5;
	for(var i=0,hoek=Math.PI*3/2;i<10;hoek+=incr,i++) {
		var x=Math.cos(hoek)*r+width/2;
		var y=Math.sin(hoek)*r+39*height/80;
		dc.drawText(x, y,monthfont,months[i],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
		}
	dc.drawText(wmid, height*2/5,monthfont,months[10],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
	dc.drawText(wmid, height*3/5,monthfont,months[11],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
	}
}
