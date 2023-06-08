using Toybox.WatchUi;
using Toybox.Application.Storage;

using Toybox.Communications;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;
class datChange {
var val;
function initialize(valin) {
	val=valin;
	}

function orig() {
	return val[1].format("%g");
	}
function storedata(numstr) {
	var floval=numstr.toFloat();
	if(floval==null) {
		beep3();
		return false;
		}
	var prec=precvars[val[2]];
	var rounded=round(floval,prec);
	val[1]=rounded;
	return true;
	}
}

class varChange {
var val;
function initialize(valin) {
	val=valin;
    	}
function vardone(varid) {
	val[2]=varid;
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	}

function onleft() {
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	}
}


class number {
  var nums;
    function initialize() {
	nums=[];
//	nums=(changer.orig()).toCharArray();
	}
}


    function getnum(changer,label) {
		var nums=new number();
		var dial=new DialDelegate(changer,nums);
		var vor=changer.orig();
		if(vor.length()) {
			dial.saved.add(vor);
			}
		WatchUi.pushView(new DialView(nums,label),dial,WatchUi.SLIDE_IMMEDIATE) ; 
		}
class ItemDelegate extends WatchUi.BehaviorDelegate {
var datanum;
var val;
var oldval;
var numbase;
    function initialize(base,dat,valin) {
        BehaviorDelegate.initialize();
	numbase=base;
	 datanum=dat;
	val=valin;
	oldval=[ val[0],val[1],val[2] ];

    }
    function onBack() {
    	var len=oldval.size();
	for(var i = 0; i < len; i++ ) {
		if(val[i]!=oldval[i]) {
			var dialog = new WatchUi.Confirmation("Cancel modification?");
			WatchUi.pushView( dialog, new CancelConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
			return true;
			}
		}
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
function testtime(base,it,tim)  {
	var nu=Time.now().value();
	if((tim-nu)>5184000) {
		beep2();
		return false;
		}
	var older=it-maxstorage/4;
	if(older>minimum[numbase]) {
		var oldval=getval(base,older);
		if(oldval!=null&&oldval[0]>tim) {
			return false;
			}
		}
	return true;
	}
 function onTap(clickEvent) {
if(clickEvent.getType() == CLICK_TYPE_TAP ) { 
        var co=clickEvent.getCoordinates();
	var id=co[1]*4/height;
	var x=co[0];
	switch(id) {
		case 0: var el=x*2/width;
			switch(el) {
				case 0: 
				getnum( new hourChange(val),"Hour");
				break;
				case 1: 
				getnum( new minChange(val),"Minute");
				break;
				}
				 break;
		case 1:el=x*3/width;
			switch(el) {
				case 0: getnum(new dayChange(val),"Day");break;
				case 1:  WatchUi.pushView(new MonthView(), new MonthDelegate(val) ,WatchUi.SLIDE_IMMEDIATE) ; break;
				case 2: getnum(new yearChange(val),"Year");break;
				}
			break;
		case 2:el=x*2/width;
			switch(el) {
				case 0: 
				WatchUi.pushView(new VarView(), new VarDelegate(new varChange(val)) ,WatchUi.SLIDE_IMMEDIATE) ; break;

				case 1: 
					getnum(new datChange(val),vars[val[2]]);break;
				}
			break;
		case 3:el=x*2/width;
			switch(el) {
				case 0: {
					var dialog = new WatchUi.Confirmation("Delete "+vars[oldval[2]]+" "+oldval[1].format("%g")+"?");
					WatchUi.pushView( dialog, new DeleteConfirmationDelegate(numbase,datanum), WatchUi.SLIDE_IMMEDIATE);
					}
					break;
				case 1: 
					if(val[0]!=oldval[0]) {
						if(!testtime(numbase,datanum,val[0]))   {
							var tim=new Time.Moment(val[0]);
							var daginf = Gregorian.info(tim, Time.FORMAT_SHORT);
							var dialog = new WatchUi.Confirmation("Move to "+ daginf.day+"-"+months[daginf.month-1]+"-"+daginf.year +"?");
							WatchUi.pushView( dialog, new FarWayConfirmationDelegate(numbase,datanum,val), WatchUi.SLIDE_IMMEDIATE);
							
							break;
							}
						var itemdatanum=moveondate(numbase,datanum,val); 
						}
					else {
						if(val[1]!=oldval[1]||val[2]!=oldval[2])  {
							setval(numbase,datanum,val);
							}
						else {
							WatchUi.popView(WatchUi.SLIDE_IMMEDIATE); 
						}
						
						}
					havenums(numbase);
					WatchUi.popView(WatchUi.SLIDE_IMMEDIATE); 
					break;
				}
			break;

			
		}

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
