using Toybox.WatchUi;
using Toybox.Lang;
using Toybox.Math;
using Toybox.StringUtil;

class OperatorDelegate extends WatchUi.BehaviorDelegate {
var nums;
var straal2;
function initialize(n) {
    nums=n;
    straal2=Math.pow(height/4.0,2);
    BehaviorDelegate.initialize();
    setselect(2);
    }
    function onBack() {
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
function addoperator(mo) {
    var chr=operators[mo].toCharArray();
    if((nums.nums.size()+chr.size())<=nummax) {
        nums.nums=nums.nums.addAll(chr);
        if(!(chr.size()==1&&chr[0]=='.')) {
            operated=1;
            }
        }
    else {
        beep2();
        }
     }
function rounder() {
        var getstr=StringUtil.charArrayToString(nums.nums);
        var floval=getstr.toFloat();
        if(floval!=null) {
            var num=Math.round(floval);
            var str=num.format("%d");
            nums.nums=str.toCharArray();
            }
        else {
            beep4();
            }
        }
function selvalue() {
        var str=calcer(nums);
        if(str) {
            nums.nums=str.toCharArray();
            }
        }
 function onTap(clickEvent) {
    if(clickEvent.getType() == CLICK_TYPE_TAP ) { 
        fromback=false;
        var co=clickEvent.getCoordinates();
        var x=co[0]-width/2;
        var y=co[1]-height/2;
        var rsq=Math.pow(x,2)+Math.pow(y,2);
        var len=operators.size();
        var mo;
        if(rsq<straal2) {
            if(y<0) {
                rounder();
                }
            else {
                selvalue();
                    
            }
        }
    else {
        var part=360/len;
        var hpart=part/2;
        var arc=180.0d*(1.0d-Math.atan2(x,y)/Math.PI);
        if(arc<hpart || arc>(360-hpart)) {
            nums.nums=[];
            }
        else {
            mo=Math.floor((arc+hpart)/part).toNumber();
            addoperator(mo);
            }
        }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
     return true;
    }

  function      switch2sel(sel) {
        if(sel>0&&sel<operators.size()) {
             addoperator(sel);
             }
         else {
            switch(sel) {
                case 0: nums.nums=[];break;
                case 9: rounder();break;
                default: selvalue();
                }
             }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }

public function processKey(evt as WatchUi.KeyEvent,maxitem as Lang.Number,selected as Lang.Number) as Lang.Number {
       var key=evt.getKey();
       switch(key) { 
            case Toybox.WatchUi.KEY_UP:  {
                ++selected;
                if(selected>maxitem) {
                    selected=0;
                    }
                WatchUi.requestUpdate();
               break;
                 }
            case Toybox.WatchUi.KEY_DOWN:  {
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
 function onKey(keyEvent) {
     if(alarmactive) {
         stopalarm();
         }
     else {
        
        var res=processKey(keyEvent,9,selected);
        if(res<0) {
             switch2sel(selected);
             }
        else {
            selected=res;
            }
        }
   return true;
    }
/*
  function onPreviousPage() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    } */

    function onSwipe(swipe) {
        switch(swipe.getDirection()) { 
            case WatchUi.SWIPE_DOWN: 
            case WatchUi.SWIPE_RIGHT: {
                   WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                    break;
                    }
            }
        return true;
        }



}


