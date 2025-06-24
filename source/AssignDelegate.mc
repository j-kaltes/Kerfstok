using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;
import Toybox.Lang;

class AssignDelegate extends WatchUi.BehaviorDelegate {
var from=0;
var nums as number;
var onscr=4;
var assSelected=-1;
    function initialize(n as number) {
        BehaviorDelegate.initialize();
        if(selected>=0) {
            assSelected=0;
            }
        nums=n;
        }
    function onBack() {
	       WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
function newcopy(input as Array<Char>) as Array<Char> {
        var uit=new [input.size()];
        for(var i=0;i<input.size();++i) {
                uit[i]=input[i];
                }
        return uit;
        }
function saveid(idin) {
    var id=from+idin;
	if(id<initer.memlab.size()) {	
		var was=numset.indexOf(id);
		if(nums.nums.size()) {
			if(was<0) {
				numset.add(id);
				}
////			memnum[id]=[].addAll(nums.nums) as Array<Char>;
			memnum[id]=newcopy(nums.nums as Array<Char>);
			}
		else {
			if(was>=0) {
				memnum[id]=[];
				}
			}
		}
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
 function onTap(clickEvent) {
    if(clickEvent.getType()==CLICK_TYPE_TAP) { 
            var co=clickEvent.getCoordinates();
//            var id=(onscr-(co[1]*onscr/height)-1);
            var id=co[1]*onscr/height as Number;
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
        var maxon=initer.memlab.size()-from;
        if(onscr<maxon) {
            maxon=onscr;
            }
        var res=processKey(keyEvent,maxon-1,assSelected);
        if(res<0) {
            saveid(assSelected);
             }
        else {
            assSelected=res;
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
    function next() {
	if(from<=0) {
       		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		return true;
		}
	from=from-onscr;
	 WatchUi.requestUpdate();
        return true;
    }

    function previous() {
	var grens=initer.memlab.size()-onscr;
	from=from<grens?from+onscr:from;
	 WatchUi.requestUpdate();
        return true;
	}
    function onMenu() {
        return true;
    }
}
