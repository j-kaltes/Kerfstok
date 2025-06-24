using Toybox.WatchUi;
using Toybox.Lang;
using Toybox.System;

class MemoryDelegate extends WatchUi.BehaviorDelegate {
var gegs,nums;
    function initialize(g,n) {
	gegs=g;
	nums=n;
        BehaviorDelegate.initialize();
    }
    function onBack() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

 function onTap(clickEvent) {
    if(clickEvent.getType() == CLICK_TYPE_TAP ) { 
            var co=clickEvent.getCoordinates();
            var id=co[1]*gegs.pos.size()/height;
            var x=co[0]*gegs.pos[id]/width;
            var	p=gegs.startpos;
            for(var i=0;i<id;i++)	{
                    p+=gegs.pos[i];
                    }
            p+=x;
            if(p<gegs.previous.size()) {
                    fromback=false;
                    nums.nums.addAll(gegs.previous[p].toCharArray());
                    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                    }

        }


            return true;
        }

function    saveid(sel) {
    var id=gegs.startpos+sel;
    fromback=false;
    nums.nums.addAll(gegs.previous[id].toCharArray());
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
public function processKey(evt as WatchUi.KeyEvent) as Lang.Boolean {
       var key=evt.getKey();
       var	startpos=gegs.startpos;
       var  nr=gegs.previous.size();
       var onscr=gegs.onscreen;
       var over=nr-startpos;
       switch(key) { 
            case Toybox.WatchUi.KEY_DOWN:  {
                ++gegs.memSelected;
                if(gegs.memSelected>=over) {
                        beep4();
                        --gegs.memSelected;
                        }
                else {
                    if(gegs.memSelected>=onscr) {
                        if(next()) {
                            gegs.memSelected=0;
                            }
                        else {
                            beep4();
                            --gegs.memSelected;
                            }
                        }
                     }
                WatchUi.requestUpdate();
               break;
                 }
            case Toybox.WatchUi.KEY_UP:  {
                --gegs.memSelected;
                if(gegs.memSelected<0) {
                        if(previousScreen()) {
                            gegs.memSelected=onscr-1;
                            }
                        else {
                               beep4();
                              ++gegs.memSelected;
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
                saveid(gegs.memSelected);
                }
             }
         return true;
        }

    function onSwipe(swipe) {
        switch(swipe.getDirection()) { 
            case WatchUi.SWIPE_UP: next();break;
            case WatchUi.SWIPE_DOWN: previousScreen();break;
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
function previousScreen() {
    	if(gegs.startpos>0) {
		gegs.startpos-=gegs.onscreen;
		if(gegs.startpos<0) {
			gegs.startpos=0;
			}
		WatchUi.requestUpdate();
                return true;
		}
        return false;
	}
function next() {
	gegs.startpos+=gegs.onscreen;
    if(gegs.startpos>=gegs.previous.size()) {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	    return false;
        }
	else {
		WatchUi.requestUpdate();
        return true;
		}
    }




}


