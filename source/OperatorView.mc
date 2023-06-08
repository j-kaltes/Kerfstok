using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.StringUtil;
using Toybox.System;
var operators=["C","^","*","/","+","-","(",")","."];
class OperatorView extends WatchUi.View {
const numsfont= Gfx.FONT_TINY;
const operatorfont= Gfx.FONT_LARGE;
var nums;
    function initialize(numin) {
        View.initialize();
	nums=numin;

    }

 function onLayout(dc) {
   }

//function onShow() {
 //   }

const	timeoff=edgeexplore2? height*.19:(edge830?(theight*0.4):clockhight);

    function onUpdate(dc) { 
	dc.clearClip();
	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
	dc.clear();
	dc.setColor(Gfx.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
var myTime = System.getClockTime(); // ClockTime object
	dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
	var fw=dc.getTextWidthInPixels(operators[0], operatorfont);
	var r=width/2 - fw;
	var incr=2*Math.PI/operators.size();
//	dc.drawText(width/2, clockhight,operatorfont,operators[0],Gfx.TEXT_JUSTIFY_CENTER );
	dc.drawText(width/2,timeoff ,operatorfont,operators[0],Gfx.TEXT_JUSTIFY_CENTER );
	for(var i=1,hoek=Math.PI*3/2+incr;i<operators.size();hoek+=incr,i++) {
		var x=Math.cos(hoek)*r+width/2;
		var y=Math.sin(hoek)*r+39*height/80;
		dc.drawText(x, y,operatorfont,operators[i],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
		}
	dc.drawText(width/2, height/3,Gfx.FONT_XTINY,"Round",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
	var getstr= StringUtil.charArrayToString(nums.nums);
//	dc.drawText(xnumbers,  hmidnum, Gfx.FONT_LARGE,getstr, Gfx.TEXT_JUSTIFY_LEFT );
	var en=(getstr.length()+maxline-1)/maxline;
	for(var i=0;i<en;i++) {
		var sub=getstr.substring(i*maxline,(i+1)* maxline);
		dc.drawText(xnumbers,  hmidnum+i*hnumfont, numsfont,sub, Gfx.TEXT_JUSTIFY_LEFT );
		} 
	}

}
