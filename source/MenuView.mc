using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Activity;
using Toybox.ActivityRecording;
using Toybox.Lang;

class MenuView extends WatchUi.View {

function initialize() {
        View.initialize();
    }
    var itemheight=height/5;

    function onUpdate(dc) { 
        dc.clearClip();
        dc.setColor(foreground, background);
        dc.clear();
        var myTime = System.getClockTime(); // ClockTime object
        dc.drawText(wmid, clocky, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
      selon(dc,0);
      dc.drawText(wmid/2, itemheight, Gfx.FONT_TINY,"Save",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT );
      seloff(dc,0); 
      dc.drawText(wmid*3/2, itemheight, Gfx.FONT_TINY,"Esc",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT );
      seloff(dc,1); 
      dc.drawText(wmid/4,itemheight*2, Gfx.FONT_TINY,"Hist",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT );
      seloff(dc,2); 
      dc.drawText(wmid, itemheight*2, Gfx.FONT_TINY,"M+",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
      seloff(dc,3); 
      dc.drawText(width-wmid/4, itemheight*2, Gfx.FONT_TINY,"MR",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT );
      seloff(dc,4); 
      dc.drawText(wmid/4, itemheight*3, Gfx.FONT_TINY,"Operators",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_LEFT );
      seloff(dc,5); 
      dc.drawText(width-wmid/4, itemheight*3, Gfx.FONT_TINY,"Calc",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_RIGHT );
      seloff(dc,6); 
      dc.drawText(wmid, itemheight*4, Gfx.FONT_TINY,"Shortcuts",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );

        }
  }


class MenuDelegate extends WatchUi.BehaviorDelegate {
   var dial;
    function initialize(dialin) {
        dial=dialin;
        BehaviorDelegate.initialize();
        setselect(0);
    }

function onBack() {
   WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
   return true;
    }
 public function onKey(evt as WatchUi.KeyEvent) as Lang.Boolean {
    if(alarmactive) {
           stopalarm();
            }
    else {
          if(selected>=0) {
                var res=processKey(evt,7,selected);
                if(res<0) {    
                        selectview(selected);
                        }
                else {
                        selected=res;
                        }
               }
          else  {
            askstopsport();
            }
        }
    return true;
    }
 function   selectview(id) {
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    switch(id) {
        case 0: dial.saveData();break;
        case 1: WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);break;
        case 2: dial.previous();break;
        case 3: {
            var del=new AssignDelegate(dial.nums);
            WatchUi.pushView(new AssignView(del), del,WatchUi.SLIDE_IMMEDIATE) ;
            break;
            }
        case 4: {
            var del=new RetrieveDelegate(dial.nums);
            WatchUi.pushView(new RetrieveView(del), del,WatchUi.SLIDE_IMMEDIATE) ;
            break;
            }
        case 5: dial.next();break;
        case 6: dial.calcData();break;
        case 7:  {
                    var del=new CutDelegate(dial.nums);
                    WatchUi.pushView(new CutView(del), del,WatchUi.SLIDE_IMMEDIATE) ;
                    };break;

        }
    }
 function onTap(clickEvent) {
        var co=clickEvent.getCoordinates();
        var id=co[1]*4/height;
        var x=co[0];
        var sel;
        switch(id) {
            case 0: {
                var el=x*2/width;
                sel=el;
                break;
                }
            case 1: {
                var el=x*3/width;
                sel=el+2;
                break;
                }
            case 2: {
                var el=x*2/width;
                sel=el+5;
                break;
                }
            case 3:
                sel=7;
                break;
            default:
                return false;
             }
        selectview(sel);
        return true;
    }

}
