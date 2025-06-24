using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;
using Toybox.Lang;

class CutDelegate extends WatchUi.BehaviorDelegate {
   var cutSelected=-1;
    var from=0;
    var onscr=4;
    var nums;
    function initialize(n) {
        BehaviorDelegate.initialize();
        nums=n;
        if(selected>=0) {
                cutSelected=0;
                }
        }
    function onBack() {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            return true;
        }
     function saveid(idin) {
            var id=idin+from;
            if(id<shortcuts.size()) {    
                fromback=false;
                nums.nums.addAll(shortcuts[id][1].toCharArray());
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                }
            }
     function onTap(clickEvent) {
        if(clickEvent.getType() == CLICK_TYPE_TAP ) { 
            var co=clickEvent.getCoordinates();
            var id=co[1]*onscr/height;
            saveid(id);
            }
            return true;
        }

public function processKey(evt as WatchUi.KeyEvent) as Lang.Boolean {
        var maxcuts=shortcuts.size();
        var over=maxcuts-from;

       var key=evt.getKey();
       switch(key) { 
            case Toybox.WatchUi.KEY_DOWN:  {
                ++cutSelected;
                if(cutSelected>=over) {
                        beep4();
                        --cutSelected;
                        }
                else {
                    if(cutSelected>=onscr) {
                        if(next()) {
                            cutSelected=0;
                            }
                        else {
                            beep4();
                            --cutSelected;
                            }
                        }
                     }
                WatchUi.requestUpdate();
               break;
                 }
            case Toybox.WatchUi.KEY_UP:  {
                --cutSelected;
                if(cutSelected<0) {
                        if(previous()) {
                            cutSelected=onscr-1;
                            }
                        else {
                               beep4();
                              ++cutSelected;
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
        else  {
            if(processKey(keyEvent)) {
                saveid(cutSelected);
                }
             }
         return true;
        }

    function onSwipe(swipe) {
        switch(swipe.getDirection()) { 
            case WatchUi.SWIPE_UP: next();break;
            case WatchUi.SWIPE_DOWN: previous();break;
            case WatchUi.SWIPE_RIGHT: {
                   WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                    break;
                    }
            case WatchUi.SWIPE_LEFT: {
                        break;
            }
            }
        return true;
        }
    function previous() {
        if(from>0) {
            from=from-onscr;
            WatchUi.requestUpdate();
            return true;
            }
        return false;
        }

    function next() {
        var grens=shortcuts.size()-onscr;
        if(from<grens) {
            from=from+onscr;
            WatchUi.requestUpdate();
            return true;
            }
         return false;
        }
        function onMenu() {
            WatchUi.pushView(new HistView(), new HistDelegate(),WatchUi.SLIDE_IMMEDIATE) ;
            return true;
        }
}
