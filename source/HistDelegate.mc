using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Lang;
using Toybox.Time.Gregorian;
function setselect(val) {
        if(selected>=0) {
           selected=val;
           }
        }
var histselected=-1;
class HistDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        if(selected>=0) {
                histselected=0;
                }
        BehaviorDelegate.initialize();
    }
    function onBack() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	return true;
    }
function selitem(id) {
	if(id<maxshown) {
		var toonid=shown[id];
		var base=shownbase[id];
		var val=getval(base,toonid);
		if(val&&val[2]>=0&&val[2]<varnr) {
			WatchUi.pushView(new ItemView(val), new ItemDelegate(base,toonid,val),WatchUi.SLIDE_IMMEDIATE) ;
			}
		}
        }
 function onTap(clickEvent) {
        var co=clickEvent.getCoordinates();
	var id=co[1]*histrows/height;
        selitem(id);
        return true;
    }
function dayback() {
	if(item0>minimum[0]||item1>minimum[1]) {
		var nday=1893452400;
		for(var i=histrows-1;i>=0;i--) {
			var val=getval(shownbase[i],shown[i]);		
			if(val!=null) {
				nday=val[0]-60*60*23;
				break;
				}
			}

		showiter0=item0;showiter1=item1;
		for(;showiter0>=minimum[0];showiter0--) {
			var val0=getval(0,showiter0);
			if(val0!=null&&val0[0]<nday) {
				break;
				}
			}
		for(;showiter1>=minimum[1];showiter1--) {
			var val1=getval(1,showiter1);
			if(val1!=null&&val1[0]<nday) {
				break;
				}
			}
		WatchUi.requestUpdate();
		return true;
		}
		return false;
	}



public function processKey(evt as WatchUi.KeyEvent) as Lang.Boolean {
       var key=evt.getKey();
       switch(key) { 
            case Toybox.WatchUi.KEY_DOWN:  {
                ++histselected;
                if(histselected>3) {
                      if(next()) {
                            histselected=0;
                            }
                      else {
                            --histselected;
                            }
                      }
                 else {
	              if(histselected>=maxshown) {
                        beep4();
                        --histselected;
                        }
                     }
                  WatchUi.requestUpdate();
                break;
                 }
            case Toybox.WatchUi.KEY_UP:  {
                --histselected;
                if(histselected<0) {
                        if(previous()) {
                            histselected=3;
                            }
                        else {
                              ++histselected;
                              }
                        }
                WatchUi.requestUpdate();
                break;
                }
            case Toybox.WatchUi.KEY_ENTER:  {
               selitem(histselected);
                return true;
                }
            case Toybox.WatchUi.KEY_ESC:  {
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                return false;
                }
            }
        return false;
       }
 function onKey(keyEvent) {
     if(alarmactive) {
         stopalarm();
         }
     else {
        processKey(keyEvent);
        }
     return true;
    }



function onSwipe(swipe) {
    switch(swipe.getDirection()) { 
        case WatchUi.SWIPE_UP: next();break;
        case WatchUi.SWIPE_DOWN: previous();break;
	case WatchUi.SWIPE_LEFT: {
        	return dayback() ;
		}
        }
    return true;
    }
function previous() {
	var it0=showiter0+1;	
	var it1=showiter1+1;
	for(var i=0;i<histrows&&(it0<storageid[0]||it1<storageid[1]);i++) {	
		var tim0=1893452400,tim1=1893452400;
		while(it0<storageid[0])	{
			var val=getval(0,it0);
			if(val!=null) {
				tim0=val[0];		
				break;
				}
			it0++;
			}
		while(it1<storageid[1])	{
			var val=getval(1,it1);
			if(val!=null) {
				tim1=val[0];		
				break;
				}
			it1++;
			}
		if(tim0<tim1) {	
			it0++;
			}
		else {
			if(it1<storageid[1]) {
				it1++;
				}
			else {
				break;
				}
			}

		}
        var newid0=it0-1;
        var newid1=it1-1;
        var changed=false;
        if(newid0!=showiter0) {
	            showiter0=newid0;
                changed=true;
                }
        if(newid1!=showiter1) {
                showiter1=newid1;
                changed=true;
                }
         if(changed) {
             WatchUi.requestUpdate();
             }
         else {
            beep4();
            }
        return changed;
        }


function next() {
	if(item0<minimum[0]&&item1<minimum[1]) {
		beep1();
		return false;
		}
	showiter0=item0;
	showiter1=item1;
	WatchUi.requestUpdate();
	return true;
    }


}
