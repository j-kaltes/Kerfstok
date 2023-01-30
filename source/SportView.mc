using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Activity;
using Toybox.ActivityMonitor;

var endlap=0;
class SportView extends WatchUi.View {
    function initialize() {
        View.initialize();
    }



var gluheight;
var hheight;

//const	unitlower=venu?0:height*0.038;
const	unitlower=venu?0:height*0.030;
const fromh=venusq2?10:0; 
const ydist=((venusq||venusq2)?(height*.65):(fenix7?(height*.635):(edgeexplore2||edge830)?height*.7:(height*.59)));
const ydistunits=(fenix7?(height*.64):(edgeexplore2?(height*.67):(height*.65)));
const sporttime=venusq2?Gfx.FONT_LARGE:Gfx.FONT_NUMBER_MILD;
const speedfont=(venusq2||fenix7)?Gfx.FONT_NUMBER_MEDIUM:Gfx.FONT_NUMBER_HOT;
const glucosefont=venusq2?Gfx.FONT_SYSTEM_NUMBER_HOT:Gfx.FONT_SYSTEM_NUMBER_THAI_HOT;
const gpsfont=venusq2?Gfx.FONT_MEDIUM:Gfx.FONT_LARGE;

const speedunitJust=(fenix7||venusq2||venusq)?(Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_RIGHT):Gfx.TEXT_JUSTIFY_RIGHT;
const speedy=fenix7?(height*.61):( venusq2?(height*.65):(( edgeexplore2||edge830)?(height*.48):(height*.59)));
const lapsfont=fenix7?Gfx.FONT_LARGE:Gfx.FONT_NUMBER_MEDIUM;
var starty,y;
var 	speedunity;
const lapvaluey=venusq2?(fh+height*.60): (edgeexplore2?(height*.57): (fromh+height*.57));
const x=width*.57;
const fh=fromh-height*0.05;
var verh;
var	lapnamey,timey;
function onLayout(dc) {
	hheight= dc.getFontHeight(sporttime);
	 gluheight= dc.getFontHeight(glucosefont);
	starty=((edgeexplore2||edge830)?height*.065:0)+(hheight*.78-gluheight*.2);
	y=starty+gluheight*0.8;
 	speedunity=marq2?(0.42*height):(fenix7?(0.50*height):(venusq2?(0.51*height):((venusq)?(0.45*height):(edgeexplore2?height*.37:(y+unitlower)))));
 	lapnamey= venusq2?(y+fh+0.01*height):((edgeexplore2)?0.47*height:( edge830? 0.45*height:(y+fromh+0.01*height)));
	verh=y-fromh;
	dc.setPenWidth(height*.02);
	if(edgeexplore2) {
		timey=0;
		}
	else {
		if(edge830) {
			timey=-hheight*.06;
			}
		else  {
			timey=-hheight*.12;
			}
		}
	}
    function onUpdate(dc) { 
	dc.clearClip();
	dc.setColor(foreground, background);
	 dc.clear();
	var unixnu=Time.now().value();

	var myTime = Gregorian.info(new Time.Moment(unixnu) , Time.FORMAT_MEDIUM);
	dc.drawText(wmid, timey, sporttime,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_CENTER );
	var vers=unixnu-glucosetime;
	
	if(vers<maxver) {
		var dlen=width*.6;
		var beg=dlen*vers/maxver;
		var dims=dc.getTextDimensions(sensorversion,Gfx.FONT_XTINY);
		dc.setColor(Gfx.COLOR_PURPLE,Gfx.COLOR_TRANSPARENT);
		var xid= x-dims[0]/2;
		dc.fillRectangle(xid, verh+1, dims[0]*vers/maxver, dims[1]);
		dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
	 	dc.drawText(x,verh,Gfx.FONT_XTINY,sensorversion, Gfx.TEXT_JUSTIFY_CENTER);
	 	dc.drawText(width*.6,starty , glucosefont,glucosestr,Gfx.TEXT_JUSTIFY_CENTER);
		if(glucoserate==-20) {
	 		dc.drawText(width*.9,hheight , Gfx.FONT_LARGE ,">", Gfx.TEXT_JUSTIFY_RIGHT);
			}
		else  {
			if(glucoserate==20) {
				dc.drawText(width*.9,hheight  , Gfx.FONT_LARGE ,"<", Gfx.TEXT_JUSTIFY_RIGHT);
				}	
			}

	//	dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);

	dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
		//dc.setColor(0x49099c, Gfx.COLOR_TRANSPARENT);

//		dc.setColor(0xff5112, Gfx.COLOR_TRANSPARENT);
		if(dc has :setAntiAlias) {
			dc.setAntiAlias(true);
			}
		if(glucoserate!=20.0&&glucoserate!=-20.0) {
			var yp=starty+gluheight*.54;
	//		var xline=xid-width*0.0093;
			drawarrow(dc,width,height,width*0.3,yp,density*0.7);
//			var xline=width*.2;
//			dc.drawLine(xline*.5, yp+glucoserate*height*.05, xline, yp);
			}
		dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
		}
	else {
		dc.setColor(foreground, Gfx.COLOR_TRANSPARENT);
		}
	if(locinfo!=null) {
		var showspeed=locinfo.speed*toshowspeed;
		dc.drawText(width,speedunity ,Gfx.FONT_XTINY,speedunits, speedunitJust);
		dc.drawText(width*.98,speedy,speedfont,showspeed.format("%.0f"), Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_RIGHT);
		}
	else {
		if(activityrecord==null) {
			dc.drawText(wmid,height*.54 ,gpsfont,"Finished",  Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER);
			}
		else {
			dc.drawText(wmid,height*.54 ,gpsfont,"Waiting for GPS",  Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER);
			}
		}
	var hr=0;
	if(actinfo!=null) {
		if(actinfo.elapsedDistance!=null) {
			var dist= actinfo.elapsedDistance*toshowdistance;
			dc.drawText(width*.13,ydist ,speedfont, dist.format("%.1f"),Gfx.TEXT_JUSTIFY_LEFT);
			if(showdistanceunit) {
				dc.drawText(width*.12,ydistunits ,Gfx.FONT_XTINY,distanceunits, Gfx.TEXT_JUSTIFY_RIGHT);
				}
			}
		if(actinfo.currentHeartRate!=null)  {
			hr=actinfo.currentHeartRate;
			}
		}
	if(unixnu<endlap) {
		dc.drawText(width*.04, lapnamey , Gfx.FONT_XTINY,lapstr1,Gfx.TEXT_JUSTIFY_LEFT );
		dc.drawText(0, lapvaluey , lapsfont,lapstr2,Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_LEFT ); 
		}


	if(hr==0) { 
		if( Toybox has :ActivityMonitor&& Toybox.ActivityMonitor has :getHeartRateHistory) {
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
	dc.drawText(wmid,height-hheight*.88,sporttime,hr.format("%d"), Gfx.TEXT_JUSTIFY_CENTER);
	}

}
