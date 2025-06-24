using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;

var numset=[];
class RetrieveDelegate extends WatchUi.BehaviorDelegate {
var from;
var nums;
var onscr=4;
function initialize(n) {
   nums=n;
   if(numset.size()<1) {from=0;} else {
      from=((numset.size()-1)/onscr)*onscr;
         }
    BehaviorDelegate.initialize();
    setselect(0);
    }
    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
function saveid(idin) {
       var id=from+idin;
       if(id<numset.size()) {
          fromback=false;
          nums.nums.addAll(memnum[numset[id]]);
          WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
          }
       else {
          beep4();
          }
        }

function onTap(clickEvent) {
    if(clickEvent.getType()==CLICK_TYPE_TAP) { 
       var co=clickEvent.getCoordinates();
       var id=co[1]*onscr/height;
       saveid(id);
       return true;
       }
    return false;
    }

 function onKey(keyEvent) {
    if(alarmactive) {
       stopalarm();
       }
    else {
        var maxon=numset.size()-from;
        if(onscr<maxon) {
                maxon=onscr;
                }
        var res=processKey(keyEvent,maxon-1,selected);
        if(res<0) {
                saveid(selected);
                }
        else {
                selected=res;
                }
        }
    return true;
    }

function onSwipe(swipe) {
    switch(swipe.getDirection()) { 
        case WatchUi.SWIPE_UP: next();break;
        case WatchUi.SWIPE_DOWN: previous();break;
        case WatchUi.SWIPE_LEFT: {
                    break;
                      }
        }
    return true;
    }
function previous() {
   from=(from<onscr)?0:from-onscr;
    WatchUi.requestUpdate();
        return true;
    }

    function next() {
   var grens=numset.size()-onscr;
   if(from>=grens) {
          WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
          return true;
      }
   from=from+onscr;
    WatchUi.requestUpdate();
        return true;
   }
    function onMenu() {
        return true;
    }
}
