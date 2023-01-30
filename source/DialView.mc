using Toybox.WatchUi;
using Toybox.System;
using Toybox.StringUtil;
using Toybox.Graphics as Gfx;
using Toybox.Math;
using Toybox.Time;
using Toybox.Time.Gregorian;

var toshow=1;
const maxline=11;
var numwidth;
class DialView extends WatchUi.View {
const numsfont= venusq2?Gfx.FONT_XTINY:((edgeexplore2||edge830)?Gfx.FONT_MEDIUM:Gfx.FONT_TINY);


const	dialnumberfont=venusq2?Gfx.FONT_NUMBER_MEDIUM:Gfx.FONT_NUMBER_HOT;
var nums;

//var numiter;
var variable;
var timeoff=0.0;
    function initialize(numin,vari) {
        View.initialize();
	variable=vari;
	nums=numin;
	timeoff=System.SCREEN_SHAPE_RECTANGLE==screenShape?
(edgeexplore2?height*.15:(edge830?(theight*0.3):(theight*0.1))):(width>340?theight*0.05:0.0);
	}

var vary;
    function onLayout(dc) {
	numwidth=dc.getTextWidthInPixels("9", dialnumberfont);
	var dim=dc.getTextDimensions("9", numsfont);
	wnumfont=dim[0];
	hnumfont= dim[1]*3/4;
	xnumbers=wmid-maxline*wnumfont/2;
	hmidnum=height/2-hnumfont;
	vary=hmidnum-hnumfont*7/4-(edgeexplore2|edge830?hnumfont:0);
    }
    function onShow() {
	toshow=1;	
	}

    function onUpdate(dc) { //Geen tijd: Onduidelijk of tijd nu of tijdmeting. Standaard plaats al bezet.
	if(toshow) {
		dc.clearClip();
		dc.setColor(Gfx.COLOR_WHITE, Graphics.COLOR_BLACK);

		dc.clear();
		dc.setColor(Gfx.COLOR_WHITE,Graphics.COLOR_TRANSPARENT );
		var r=width/2 - numwidth*4/5;
		var incr=Math.PI/5;
		dc.drawText(wmid, timeoff ,dialnumberfont,"0",Gfx.TEXT_JUSTIFY_CENTER );
		for(var i=1,hoek=incr+Math.PI*3/2;i<10;hoek+=incr,i++) {
	//	for(var i=0,hoek=Math.PI*3/2;i<10;hoek+=incr,i++) {
			var x=Math.cos(hoek)*r+width/2;
			var y=Math.sin(hoek)*r+39*height/80;
			dc.drawText(x, y,dialnumberfont,i,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
			}
		dc.drawText(wmid,vary , Gfx.FONT_SMALL,variable, Gfx.TEXT_JUSTIFY_CENTER );
		var myTime = System.getClockTime(); // ClockTime object
//		dc.setColor(Gfx.COLOR_BLUE,Graphics.COLOR_TRANSPARENT );
		dc.drawText(wmid,clockhight , clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
		dc.setClip(xnumbers,hmidnum,wnumfont*maxline,hnumfont*10/3);
		toshow=0;
		}
	dc.setColor(Gfx.COLOR_WHITE,Graphics.COLOR_BLACK );
	dc.clear();
	dc.setColor(Gfx.COLOR_WHITE,Graphics.COLOR_TRANSPARENT );
	var getstr= StringUtil.charArrayToString(nums.nums);
	var en=(getstr.length()+maxline-1)/maxline;
	for(var i=0;i<en;i++) {
		var sub=getstr.substring(i*maxline,(i+1)* maxline);
		dc.drawText(xnumbers,  hmidnum+i*hnumfont, numsfont,sub, Gfx.TEXT_JUSTIFY_LEFT );
		} 
	
	}

}
