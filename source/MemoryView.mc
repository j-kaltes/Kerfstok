using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;

//const maxsaved=10;
class MemoryView extends WatchUi.View {
var previous,str,str2,startpos;
const pos=[2,3,3,2],onscreen=10;


    function initialize(sav) {
	previous=sav;
	if(previous.size()>onscreen) {
		startpos=((previous.size()-1)/onscreen)*onscreen;
		}
	else {
		startpos=0;
		}	
	str=(height/2);
	str2=Math.pow(str,2);
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

var myTime = System.getClockTime(); // ClockTime object
	dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
	var hmid=height/(pos.size()+1);
	var pnr=previous.size();
	for(var r=0,i=startpos;r<pos.size()&&i<pnr;r++) {
		var len=pos[r];
		var wmid=width/(len+1);
		 var ver=hmid*(r+1);
		 var x=Math.round(Math.sqrt(str2-Math.pow(ver-str,2)));
		for(var c=0;c<len&&i<pnr;c++,i++) {
			if(c==0) {
			 	var hor=str-x;
				dc.drawText(hor, ver, Gfx.FONT_MEDIUM,previous[i],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT );
				}
			else {if(c==(len-1)) {
					var hor=str+x;
					dc.drawText(hor, ver, Gfx.FONT_MEDIUM,previous[i],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT );
					}
				else {
					dc.drawText(wmid*(c+1), ver, Gfx.FONT_MEDIUM,previous[i],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
					}
			}}
		}
	}

}
