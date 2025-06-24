using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Application.Storage;
using Toybox.Lang;
class SubSportView extends WatchUi.View {
var hmid;
//const clockfont= Gfx.FONT_LARGE;
//const clockfont= Gfx.FONT_MEDIUM;
var subs;
var from;
var subSelected=-1;
    function initialize(subsin,fromin) {
        View.initialize();
    subs=subsin;
    from=fromin;
    hmid=height/(rows+1);
    if(selected>=0) {
        subSelected=0;
        }
    }

function onShow() {
}
function onLayout(dc) {
    clockhight= dc.getFontHeight(clockfont)/((edge1040||edge840)?1.8:(edge830?2.1:2.7));
}


    function onUpdate(dc) { 
    dc.clearClip();
    dc.setColor(foreground, background);
     dc.clear();
    var myTime = System.getClockTime(); // ClockTime object
    dc.drawText(wmid, clockhight, clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );
    for(var i=0;i<rows;i++) {
        var val=from+i;
        if(val>=subs.size()) {
            break;
            }
        var su=subs[val];
        if(i==subSelected) {
            dc.setColor(background,foreground);
            }
        dc.drawText(wmid, hmid*(i+1), Gfx.FONT_MEDIUM,subsportstr[su],Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
        if(i==subSelected) {
             dc.setColor(foreground, background);
               }
        }
    }

}

class SubSportDelegate extends WatchUi.BehaviorDelegate {
var view;
//var sportkey;
    function initialize(viewin) {
        BehaviorDelegate.initialize();
    view=viewin;
//    sportkey=sportin;
    }
    function onBack() {
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

function selectsubsport(idin) {
    var id=idin+view.from;
    if(id<view.subs.size()) {
        sportdel.setsubsport(id);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
 function onTap(clickEvent) {
     var co=clickEvent.getCoordinates();
    var id=co[1]*rows/height;
    selectsubsport(id);
    return true;
    }

public function processKey(evt as WatchUi.KeyEvent) as Lang.Boolean {
       var key=evt.getKey();
       switch(key) { 
            case Toybox.WatchUi.KEY_DOWN:  {
                ++view.subSelected;
                var total=view.subSelected+view.from;
                if(total<view.subs.size()) {
                     if(view.subSelected>3) {
                            if(next()) {
                                view.subSelected=0;
                                }
                            else {
                                --view.subSelected;
                                }
                            }
                      }
                 else {
                    --view.subSelected;
                    beep4();
                    }
                WatchUi.requestUpdate();
               break;
                 }
            case Toybox.WatchUi.KEY_UP:  {
                --view.subSelected;
                if(view.subSelected<0) {
                        if(previous()) {
                            view.subSelected=3;
                            }
                        else {
                              ++view.subSelected;
                              }
                        }
                WatchUi.requestUpdate();
                break;
                }
            case Toybox.WatchUi.KEY_ENTER:  {
                return true;
                }
            }
       return false;
       }
 function onKey(keyEvent) {
     if(alarmactive) {
         stopalarm();
         }
     if(processKey(keyEvent)) {
       selectsubsport(view.subSelected);
        }
 return true;
    }


function onSwipe(swipe) {
    switch(swipe.getDirection()) { 
        case WatchUi.SWIPE_UP: next();break;
        case WatchUi.SWIPE_DOWN: previous();break;
        }
    return true;
    }
    function previous() {
        if(view.from>0)  {
            view.from-=rows;
             WatchUi.requestUpdate();
            return true;
            }
        else {
            beep4();
            return false;
            }
    }

    function next() {
        var next=view.from+rows;
        if(next<view.subs.size()) {
            view.from=next;
            WatchUi.requestUpdate();
            return true;
        }
    else {
        beep4();
        return false;
        }
    }
}
