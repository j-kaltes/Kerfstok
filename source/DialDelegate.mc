using Toybox.WatchUi;
using Toybox.System;
using Toybox.Math;
using Toybox.Lang;
using Toybox.StringUtil;
using Toybox.Time;
using Toybox.Application.Storage;
using Toybox.Timer;
const nummax=33;
var fromback=false;
  
class numStore {
var varid;
var floval;
    function initialize(id) {
	varid=id;
	}
function orig() {
	return "";
	}
function toshoweffect() {
	var tim=Time.now();
	var prec=precvars[varid];
	var rounded=round(floval,prec);
	var data=[ tim.value(),rounded,varid ];
	setval(0,storageid[0], data);
	storageid[0]++;
	showiter0=storageid[0];
	Storage.setValue(-1, storageid[0]);
//	Communications.transmit([HAVENUMS], null,  new CommListener());	

	havenums(0);
	}
function storedata(getstr) {
	floval=getstr.toFloat();
	if(floval==null) {
		beep3();
		return false;
		}
	  var myTimer = new Timer.Timer();
	  myTimer.start(method(:toshoweffect), 50 , false);
	return true;
	}
}		
  
var operated=0;

function calcer(nums) {
	var get=calc(nums.nums,nums.nums.size());
	if(get==null) {
		return null;
		}
	if(!(get has :abs)) {
		return null;
		}
	return get.format("%g");
	}

class DialDelegate extends WatchUi.BehaviorDelegate {
var nums;
var endcl;
var saved=[];

const POINT='.';
    function initialize(end,numin as number) {

	endcl=end;
	nums=numin;
        BehaviorDelegate.initialize();
    }
    function onBack() {
	if(nums.nums.size()>0) {
		if(!fromback) {
			var str=StringUtil.charArrayToString(nums.nums);
			if(saved.size()==0||!saved[saved.size()-1].equals(str)) {	
				saved.add(str);
				}
			fromback=true;
			}
		nums.nums=nums.nums.slice(0,nums.nums.size()-1);
		WatchUi.requestUpdate();
		}
	else {
	       WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		}
        return true;
    }

 function onTap(clickEvent) {
if(clickEvent.getType() == CLICK_TYPE_TAP ) { 
        var co=clickEvent.getCoordinates();
	var x=co[0]-width/2;
	var y=co[1]-height/2;
	var rsq=Math.pow(x,2)+Math.pow(y,2);
	fromback=false;
	if(rsq<2500) {
	/*
	var get=calc(nums.nums,nums.nums.size());
	if(get==null) {
		beep4();
		return false;
		}
	if(!(get has :abs)) {
		beep4();
		return false;
		}
	var str=get.format("%g");
	}
	*/
	var str=calcer(nums);
	if(str==null) {
		beep4();
		return false;
		}
		
	var numstr=StringUtil.charArrayToString(nums.nums);
	if(numstr.equals(str)) {
		if(endcl.storedata(numstr)) {
			WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	//		System.println("Timer: "+System.getTimer());
			}
		else {
			beep3();
			}
		return true;
		}

	operated=0;
	nums.nums=str.toCharArray();
	WatchUi.requestUpdate();
	return true;

}
else {

if( nums.nums.size()<nummax) {
	var arc=180.0d*(1.0d-Math.atan2(x,y)/Math.PI);

if(arc<18.0 || arc>342.0) {
//	nums.nums[nums.numiter]='0';
	nums.nums=nums.nums.add('0');
	}
else {
//	numget=numget*10+Math.floor((arc+18)/36).toNumber();
	nums.nums=nums.nums.add((Math.floor((arc+18)/36).toNumber()+48).toChar());
	}
//nums.numiter++;
WatchUi.requestUpdate();

}
else {
	beep1();
	}
	}
        return true;
    }
return false;
}

    function onNextPage() {
	if(operated==0) {
		if(nums.nums.size()) {
			var str=StringUtil.charArrayToString(nums.nums);
			if(saved.size()==0||!saved[saved.size()-1].equals(str)) {	
				saved.add(str);
				}
				}
		}
	WatchUi.pushView(new OperatorView(nums), new OperatorDelegate(nums),WatchUi.SLIDE_IMMEDIATE) ;
	return true;
	}
//var mySettings = System.getDeviceSettings();
//isGlanceModeEnabled
//onKeyPressed(keyEvent) 
 function onKey(keyEvent) {
 	if(alarmactive) {
		 stopalarm();
	 	}
	else {
		if(nums.nums.size()>(nummax-2))  {
			beep2();
			}
		else
			{
			fromback=false;
			nums.nums=nums.nums.add(POINT);
	//		nums.numiter++;
			WatchUi.requestUpdate();
			}
		}
 return true;
    }
    function onPreviousPage() {
	var view=new MemoryView(saved);
	WatchUi.pushView(view, new MemoryDelegate(view,nums),WatchUi.SLIDE_IMMEDIATE) ;
	return true;
    }

    function onSwipe(swipe) {
		if(swipe.getDirection() == WatchUi.SWIPE_LEFT) {
			var del=new CutDelegate(nums);
			WatchUi.pushView(new CutView(del), del,WatchUi.SLIDE_IMMEDIATE) ;
        		return true;
		}
	return false;
    }
function onHold(clickEvent) {
        var co=clickEvent.getCoordinates();
	if(co[0]>width/2) {
		var del=new RetrieveDelegate(nums);
		WatchUi.pushView(new RetrieveView(del), del,WatchUi.SLIDE_IMMEDIATE) ;
		}
	else {
		var del=new AssignDelegate(nums);
		WatchUi.pushView(new AssignView(del), del,WatchUi.SLIDE_IMMEDIATE) ;
		}
        return true;
    }
}
