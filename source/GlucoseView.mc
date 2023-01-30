import Toybox.Lang;
using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Activity;
using Toybox.ActivityMonitor;
using Toybox.Math;



var foreground=Gfx.COLOR_WHITE;

var background=Gfx.COLOR_BLACK;

const maxver=60*3;
//const clockfont= Gfx.FONT_XTINY;
//var glucose=0.15;
var glucoserate=0.0;
var glucosetime=0;
var sensorversion="";
var theight;
var density=1.0;
function setcolor(num) {
	if(num==1) {
		foreground=Gfx.COLOR_WHITE;
		background=Gfx.COLOR_BLACK;
		}
	else {
		foreground=Gfx.COLOR_BLACK;
		background=Gfx.COLOR_WHITE;
		}
	WatchUi.requestUpdate();
	}

function 	drawarrow(dc,width,height,xorg,yorg,density) {
	dc.setPenWidth(density*5.0);
	var getx=xorg;
	var gety=yorg;
	var rate=glucoserate;
	var x1=getx-density*40.0;
	var y1=gety+rate*density*30.0;

	var rx=getx-x1;
	var ry=gety-y1;
	var rlen= Math.sqrt(Math.pow(rx,2) + Math.pow(ry,2));


	 rx/=rlen;
	 ry/=rlen;

	var l=density*12.0;
//	var l=density*18.0;

	var addx= l* rx;
	var addy= l* ry;
	var tx1=getx-2.0*addx;
	var ty1=gety-2.0*addy;
	var xtus=getx-1.5*addx;
	var ytus=gety-1.5*addy;
	var hx=ry;
	var hy=-rx;
	var sx1=tx1+l*hx;
	var sy1=ty1+l*hy;
	var sx2=tx1-l*hx;
	var sy2=ty1-l*hy;
	dc.drawLine(x1, y1, xtus, ytus);
        dc.fillPolygon([[sx1, sy1] as Array<Float>, [getx, gety] as Array<Float>, [sx2,sy2] as Array<Float>, [xtus,ytus] as Array<Float>]  as Array< Array<Float> >);
	}

var linexpos;
class GlucoseView extends WatchUi.View {
    function initialize() {
	linexpos=venusq2?(width*0.22):(width*0.30);
        View.initialize();
    }


var heartfont=Gfx.FONT_NUMBER_MEDIUM;
var heartheight;
var timeoff=0;
var datey;
function onLayout(dc) {
//	timeoff= dc.getFontHeight(clockfont)/3;
	heartheight= dc.getFontHeight(heartfont);
//	timeoff= heartheight*.36;
	density=2.0*width/396.0;
	 if(System.SCREEN_SHAPE_RECTANGLE == screenShape) {
		if(!(edgeexplore2|| edge830)) {
		 	timeoff=-theight*0.15;
			}
		}
	else {
		if(width>340) {
			timeoff=theight*0.14;
			}
		}

	//	dc.setPenWidth(height*.02);
//		dc.setPenWidth(density*5.0);
	 datey = (edgeexplore2?height*.05:0)+(theight*.8+timeoff);
}




    function onUpdate(dc) { 
	dc.clearClip();
	dc.setColor(foreground, background);
	 dc.clear();
	var unixnu=Time.now().value();
	var myTime = Gregorian.info(new Time.Moment(unixnu) , Time.FORMAT_MEDIUM);

	var vers=unixnu-glucosetime;
	
	dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
	if(vers<maxver) {
		var yorg=height*.58;
		var y=yorg;
//		var x=width*.5;
		var x=width*.615;
	 	dc.drawText(x,y , Gfx.FONT_SYSTEM_NUMBER_THAI_HOT ,glucosestr,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER);
		if(glucoserate==-20) {
	 		dc.drawText(width*.9,y , Gfx.FONT_LARGE ,">",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT);
			}
		else  {
			if(glucoserate==20) {
				dc.drawText(width*.9,y , Gfx.FONT_LARGE ,"<",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT);
				}	
			}
		y+=height*0.12;
		var dlen=width*.6;
		var beg=dlen*vers/maxver;

		var dims=dc.getTextDimensions(sensorversion,Gfx.FONT_XTINY);
//		var dimg=dc.getTextDimensions(glucosestr,Gfx.FONT_SYSTEM_NUMBER_THAI_HOT);
		dc.setColor(Gfx.COLOR_PURPLE,background);
		var xid=x-dims[0]/2;
		dc.fillRectangle(xid, y, dims[0]*vers/maxver, dims[1]);
		dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
	 	dc.drawText(x,y ,Gfx.FONT_XTINY,sensorversion, Gfx.TEXT_JUSTIFY_CENTER);
//		dc.setColor(0x170a0b, Gfx.COLOR_TRANSPARENT);
//		dc.setColor(0xff5112, Gfx.COLOR_TRANSPARENT);

	
		if(dc has :setAntiAlias) {
			dc.setAntiAlias(true);
			}
		if(glucoserate!=-20.0&&glucoserate!=20.0) {
			drawarrow(dc,width,height,linexpos,yorg,density*.95);
			}
		dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
		}
	dc.drawText(wmid*0.99, timeoff, Gfx.FONT_NUMBER_HOT,   myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_CENTER );
	dc.drawText(wmid,  datey,Gfx.FONT_TINY,  myTime.day_of_week+" "+  myTime.day + " " + myTime.month,Gfx.TEXT_JUSTIFY_CENTER );
	var load = System.getSystemStats().battery;
	dc.drawText(width*0.95,height*.33,Gfx.FONT_XTINY,load.format("%.0f")+"%", Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_RIGHT);
	var actinfo=	Activity.getActivityInfo();
	var hr=0;
	if(actinfo!=null) {
		if(actinfo.currentHeartRate!=null)  {
			hr=actinfo.currentHeartRate;
			}
		}
	if(hr==0) { 
		if( Toybox has :ActivityMonitor &&  Toybox.ActivityMonitor has :getHeartRateHistory) {
			var sensorIter = Toybox.ActivityMonitor.getHeartRateHistory(1, true);
			if(sensorIter==null) {
				return;
				}
			var HRS=sensorIter.next();
			if(HRS!=null && HRS.heartRate!= Toybox.ActivityMonitor.INVALID_HR_SAMPLE){
				hr = HRS.heartRate;
				}
			else {
				return;
				}
			}
		else {
			return;
			}
		}
	dc.drawText(wmid,height-heartheight*.88,heartfont,hr.format("%d"), Gfx.TEXT_JUSTIFY_CENTER);
	}

}
