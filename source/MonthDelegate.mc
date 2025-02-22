using Toybox.WatchUi;
using Toybox.Math;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

function schrikkel(year) {
if(year%4==0&&(year%100||year%400==0)) {
		return true;
		}
else {
		return false;
	}
	}

function days(mo,y)  {
	if(mo==1) {
		if(schrikkel(y)) {
			return 29;
			}
		else {
			return 28;
			}
		}
	if(mo<7) {
		if(mo&1) {
			return 30;
			}
		else  {
			return 31;
			}
		}
	if(mo&1) {
		return 31;
		}
	else  {
		return 30;
		}
	}	
class MonthDelegate extends WatchUi.BehaviorDelegate {
var val;
var straal2;
    function initialize(valin) {
    	val=valin;
	straal2=Math.pow(height/4.0,2);
        BehaviorDelegate.initialize();
    }
    function onBack() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

function setmonth(mo) {
//	var date = Gregorian.info(new Time.Moment(val[0]), Time.FORMAT_SHORT);
	var date = Gregorian.utcInfo(new Time.Moment(val[0]), Time.FORMAT_SHORT);
var inmo=days(mo,date.year);
if(date.day>inmo) {
	date.day=inmo;
	}
	var options = {
	    :year   => date.year,
	    :month  => mo+1, 
	    :day    => date.day,
	    :hour   => date.hour,
	    :minute    => date.min,
	   :second => date.sec

	};
	var dat = Gregorian.moment(options);
	val[0]=dat.value();
	}

 function onTap(clickEvent) {
if(clickEvent.getType() == CLICK_TYPE_TAP ) { 
        var co=clickEvent.getCoordinates();
	var x=co[0]-width/2;
	var y=co[1]-height/2;
	var rsq=Math.pow(x,2)+Math.pow(y,2);
var mo;
	if(rsq<straal2) {
if(y>0) {
	mo=11;
	}
else {
	mo=10;
	}
}
else {

	var arc=180.0d*(1.0d-Math.atan2(x,y)/Math.PI);

if(arc<18.0 || arc>342.0) {
	mo=0;
	}
else {
	mo=Math.floor((arc+18)/36).toNumber();
	if(mo==null)	 {
		return false;}
	}

	}
	setmonth(mo);
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	}
        return true;
    }

 function onKey(keyEvent) {
 	if(alarmactive) {
		 stopalarm();
	 	}
 return true;
    }

    function onPreviousPage() {
        return true;
	}
function onNextPage() {
	return true;
    }

    function onMenu() {
        return true;
    }
}
