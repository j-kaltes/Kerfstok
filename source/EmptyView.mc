using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Activity;
using Toybox.ActivityRecording;
class ExitDelegate extends AskDelegate {

    function initialize() {
        AskDelegate.initialize();
    }
    function onResponse(response) {
        if (response == WatchUi.CONFIRM_YES) {
		if(sportdel!=null) {
			 sportdel.stopsport();
			 }
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE); 
		}
    }
}

const firstrows=4;
class EmptyView extends WatchUi.View {



var hmid;
    function initialize() {
        View.initialize();
	clockfont= (edgeexplore2||edge830)? Gfx.FONT_TINY:Gfx.FONT_XTINY;


    }
function onLayout(dc) {
	height= dc.getHeight();
	width= dc.getWidth();
	wmid=width/2;

	hmid=height/(firstrows+1);
	clockhight= dc.getFontHeight(clockfont)/3;
	theight= dc.getFontHeight(Gfx.FONT_NUMBER_HOT);
  //      WatchUi.pushView(new VarView(), new VarDelegate(new todial()),WatchUi.SLIDE_IMMEDIATE) ; 
	return true;
}


    function onUpdate(dc) { 
    	if(clockhight!=null) {
		dc.clearClip();
		dc.setColor(foreground, background);
		 dc.clear();
		var myTime = System.getClockTime(); // ClockTime object
		dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
		dc.drawText(wmid,hmid , Gfx.FONT_MEDIUM,"Input",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
		if(storageid[0]>0||storageid[1]>0) {
			dc.drawText(wmid,2*hmid , Gfx.FONT_MEDIUM,"View",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
			}

		dc.drawText(wmid,3*hmid , Gfx.FONT_MEDIUM,"Watch face",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
		dc.drawText(wmid,4*hmid, Gfx.FONT_MEDIUM,"Sport",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );

				}
	}

}



class EmptyDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    function onBack() {
       // WatchUi.pushView(new TusView(), new TusDelegate(),WatchUi.SLIDE_IMMEDIATE) ;
//	WatchUi.pushView( new WatchUi.Confirmation("Quit?"), new ExitConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
	WatchUi.pushView( new AskView("","Quit?"), new ExitDelegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
 function onKey(keyEvent) {
 	if(alarmactive) {
		 stopalarm();
	 	}
	else {
		askstopsport();
		}
        return true;

    }
 function onTap(clickEvent) {
        var co=clickEvent.getCoordinates();
	var id=co[1]*firstrows/height;
	switch(id) {
		case 0: WatchUi.pushView(new VarView(), new VarDelegate(new todial()),WatchUi.SLIDE_IMMEDIATE) ;break;
		case 1: 
			if(storageid[0]>0||storageid[1]>0) {
				WatchUi.pushView(new HistView(), new HistDelegate(),WatchUi.SLIDE_IMMEDIATE) ;
				}
			break;
		case 2: 
			WatchUi.pushView(new GlucoseView(), new GlucoseDelegate(),WatchUi.SLIDE_IMMEDIATE) ;break;
		case 3:
			if( Toybox has :ActivityRecording ) {
			    if( ( activityrecord == null ) ||activityrecord.isRecording() == false ) {
					sportdel= new SportStartDelegate();
					var view= new SportStartView();
					WatchUi.pushView(view,sportdel ,WatchUi.SLIDE_IMMEDIATE) ;
					}
				else {
					var spoview= new SportView();
					WatchUi.pushView(spoview, new SportDelegate(spoview),WatchUi.SLIDE_IMMEDIATE) ;

				}
			}
		break;
		}

        return true;
	}

    function onSwipe(swipe) {
		if(swipe.getDirection() == WatchUi.SWIPE_LEFT) {
        		WatchUi.pushView(new VarView(), new VarDelegate(new todial()),WatchUi.SLIDE_IMMEDIATE) ;
        		return true;
		}
	return false;
    }
}
