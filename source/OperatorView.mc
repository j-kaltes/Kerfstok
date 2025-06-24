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
        if(0==selected) {
                 dc.setColor(Graphics.COLOR_BLACK,Gfx.COLOR_WHITE);
                }

	dc.drawText(width/2,timeoff ,operatorfont,operators[0],Gfx.TEXT_JUSTIFY_CENTER );
        if(0==selected) {
             dc.setColor(Gfx.COLOR_WHITE,Graphics.COLOR_TRANSPARENT );
            }
	for(var i=1,hoek=Math.PI*3/2+incr;i<operators.size();hoek+=incr,i++) {
		var x=Math.cos(hoek)*r+width/2;
		var y=Math.sin(hoek)*r+39*height/80;
                if(i==selected) {
                            dc.setColor(Graphics.COLOR_BLACK,Gfx.COLOR_WHITE);
                    }
		dc.drawText(x, y,operatorfont,operators[i],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
                if(i==selected) {
                            dc.setColor(Gfx.COLOR_WHITE,Graphics.COLOR_TRANSPARENT );
                    }
		}
        if(9==selected) {
                 dc.setColor(Graphics.COLOR_BLACK,Gfx.COLOR_WHITE);
                }
        dc.drawText(width/2, height/3,Gfx.FONT_XTINY,"Round",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
        if(9==selected) {
              dc.setColor(Gfx.COLOR_WHITE,Graphics.COLOR_TRANSPARENT );
            }
	var getstr= StringUtil.charArrayToString(nums.nums);
	var en=(getstr.length()+maxline-1)/maxline;
//        if(10==selected) { dc.setColor(Graphics.COLOR_BLACK,Gfx.COLOR_WHITE); }
	for(var i=0;i<en;i++) {
		var sub=getstr.substring(i*maxline,(i+1)* maxline);
		dc.drawText(xnumbers,  hmidnum+i*hnumfont, numsfont,sub, Gfx.TEXT_JUSTIFY_LEFT );
		} 
	}

}
