using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Math;
using Toybox.Time;
using Toybox.Lang;
class SportListDelegate extends WatchUi.BehaviorDelegate {
var view;
    function initialize(viewin) {
        BehaviorDelegate.initialize();
        view=viewin;
    }
    function onBack() {
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
function sportselected(id) {
    var it=view.start;
    for(var i=0;i<id;i++) {
        it=nextsport[it];
        if(it==splen) {
            return false;
            }
        }
    tofront(it);
    sportdel.getsubsport();
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    return true;
    }
 function onTap(clickEvent) {
    var co=clickEvent.getCoordinates();
    var id=co[1]*rows/height;
    sportselected(id);
    return true;
    }

public function processKey(evt as WatchUi.KeyEvent) as Lang.Boolean {
       var key=evt.getKey();
       switch(key) { 
            case Toybox.WatchUi.KEY_DOWN:  {
                ++view.sportSelected;
                 if(view.sportSelected>3) {
                        if(next()) {
                            view.sportSelected=0;
                            }
                        else {
                            --view.sportSelected;
                            }
                        }
                WatchUi.requestUpdate();
               break;
                 }
            case Toybox.WatchUi.KEY_UP:  {
                --view.sportSelected;
                if(view.sportSelected<0) {
                        if(previous()) {
                            view.sportSelected=3;
                            }
                        else {
                              ++view.sportSelected;
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
        sportselected(view.sportSelected);
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
        var start=view.start;
        for(var i=0;i<rows;i++) {
            var tmpstart=prevsport[start];
            if(tmpstart==splen) {
                break;
                }
            start=tmpstart;
            }
    if(view.start!=start) {
        view.start=start;
        WatchUi.requestUpdate();
        return true;
        }
    else {
        beep4();
        return false;
        }
    }

function next() {
    if(view.iter<view.end) {
        view.start=view.iter;
         WatchUi.requestUpdate();
         return true;
         }
    else {
        beep4();
        return false;
        }
    }
(:debug)    function onMenu() {
        return true;

    }
}
