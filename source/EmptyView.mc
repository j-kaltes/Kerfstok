using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Activity;
using Toybox.ActivityRecording;
using Toybox.Lang;

class ExitDelegate extends AskDelegate {

    function initialize() {
        AskDelegate.initialize();
    }
    function onResponse(response) {
        if(response) {
            if(sportdel!=null) {
                 sportdel.stopsport();
                 }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE); 
        }
    }
}

const firstrows=4;

var varselected=-1;
public function processKey(evt as WatchUi.KeyEvent,maxitem as Lang.Number,selected as Lang.Number) as Lang.Number {
       var key=evt.getKey();
       switch(key) { 
            case Toybox.WatchUi.KEY_DOWN:  {
                ++selected;
                if(selected>maxitem) {
                    selected=0;
                    }
                WatchUi.requestUpdate();
               break;
                 }
            case Toybox.WatchUi.KEY_UP:  {
                --selected;
                if(selected<0) {
                        selected=maxitem;
                        }
                WatchUi.requestUpdate();
                break;
                }
            case Toybox.WatchUi.KEY_ENTER:  {
                return -1;
                }
            }
       return selected;
       }
class EmptyView extends WatchUi.View {




var hmid;
    function initialize() {
       if(selected>=0) {
            varselected=2;
            }
        View.initialize();
    clockfont= (edge1040||edgeexplore2||edge830)? Gfx.FONT_TINY:Gfx.FONT_XTINY;


    }

function onLayout(dc) {
    height= dc.getHeight();
    width= dc.getWidth();
    wmid=width/2;

    hmid=height/(firstrows+1);
    //clockhight= dc.getFontHeight(clockfont)/((edge1040||edge840)?1.8:((edge830||fr70)?2.6:2.7));
    //clockhight= dc.getFontHeight(clockfont)/((edge1040||edge840)?1.8:((edge830||fr70)?2.4:2.7));
    clockhight= dc.getFontHeight(clockfont)/((edge1040||edge840)?1.8:(edge830?2.1:2.7));
    clocky=fr70?clockhight*1.2:clockhight;
    theight= dc.getFontHeight(Gfx.FONT_NUMBER_HOT);
}
function showitem(dc,pos,str) {
        var pos1=pos-1;
        if(pos1==varselected) {
            dc.setColor(background,foreground);
            }
        dc.drawText(wmid,pos*hmid , Gfx.FONT_MEDIUM,str,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
        if(pos1==varselected) {
            dc.setColor(foreground, background);
            }
        }

    function onUpdate(dc) { 
        if(clockhight!=null) {
        dc.clearClip();
        dc.setColor(foreground, background);
         dc.clear();
        var myTime = System.getClockTime(); // ClockTime object
        dc.drawText(wmid, clocky, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
                showitem(dc,1,"Input");
                if(storageid[0]>0||storageid[1]>0) {
                                showitem(dc,2,"View");
                    }
                showitem(dc,3,"Watch face");
                showitem(dc,4,"Sport");
                }
    }

}



class EmptyDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    function onBack() {
        if(!askstopsport()) {
            WatchUi.pushView( new AskView("","Quit?"), new ExitDelegate(), WatchUi.SLIDE_IMMEDIATE);
            }
        return true;
    }
    /*
public function processKey(evt as WatchUi.KeyEvent,maxitem) as Lang.Boolean {
       var key=evt.getKey();
       switch(key) { 
            case Toybox.WatchUi.KEY_DOWN:  {
                ++varselected;
                if(varselected>maxitem) {
                    varselected=0;
                    }
                WatchUi.requestUpdate();
               break;
                 }
            case Toybox.WatchUi.KEY_UP:  {
                --varselected;
                if(varselected<0) {
                        varselected=maxitem;
                        }
                WatchUi.requestUpdate();
                break;
                }
            case Toybox.WatchUi.KEY_ENTER:  {
                return true;
                }
            }
       } */
// function onKey(evt) 
 public function onKey(evt as WatchUi.KeyEvent) as Lang.Boolean {
    if(alarmactive) {
             stopalarm();
            }
    else {
          if(varselected>=0) {
                var res=processKey(evt,3,varselected);
                if(res<0) {
                        selectview(varselected);
                     }
                else {
                   if(res!=1||storageid[0]>0||storageid[1]>0) {
                        varselected=res;
                       }
                   else {
                          if(varselected==0) {
                             varselected=2;
                             }
                         else {
                             varselected=0;
                            }
                        }

                      }
               }
          else  {
            askstopsport();
            }
        }
    return true;
    }
function selectview(id) {
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
        }
 function onTap(clickEvent) {
        var co=clickEvent.getCoordinates();
    var id=co[1]*firstrows/height;
        selectview(id);
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
