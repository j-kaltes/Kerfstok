using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;
using Toybox.Math;
using Toybox.Time;
using Toybox.Application.Storage;

(:debug) class lastChange {
    function initialize() {
	}
function orig() {
	 var last=getlastnum(0) ;
	return	last.format("%d");
	}
function storedata(numstr) {
	 var last=numstr.toNumber();
	if(last>=0&&last>=(storageid[0]-512)&&last<storageid[0]) {
		setlastnum(0,last);
		return true;
		}
	return false;
	}
}
(:debug) function makedata(num) {
	var nu=Time.now().value();
	var month=60*60*24*30;
	var tim=nu-month;
	var dist=month/num;
	for(var i=0;i<num;i++) {
		tim+=Math.rand()%dist;
		var varid=Math.rand()%varnr;
		var floval=15*Math.rand().toFloat()/Math.rand().toFloat();
		var data=[ tim,floval,varid ];
		setval2(0,storageid[0], data);
		storageid[0]++;
		}

	Storage.setValue(-1,storageid[0]);
	}	
(:debug)class sendMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
	switch(item) {
	 case 0: trans(LABELS,Time.now().value(),vars);break;
	 case 1: var last=getlastnum(0) ;
		System.println("numdata("+last+")");
		numdata(0,last);
		 break;
	case 2: getnum( new lastChange(),"LastNum");break;
	case 3: makedata(512);break;
	case 4: putlabels(["Een","Twee","Drie","Vier","Vijf","Zes","Zeven"]);break;
	default: System.println("Unknown menuitem "+item);
	}
	WatchUi.requestUpdate();
    }

}
