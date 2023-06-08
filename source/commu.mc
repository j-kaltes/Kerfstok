using Toybox.System;
using Toybox.Communications;
using Toybox.Time;
using Toybox.SensorHistory;
//using Toybox.Time.Gregorian;
// Create a method to get the SensorHistoryIterator object

// Store the iterator info in a variable. The options are 'null' in
// this case so the entire available history is returned with the
// newest samples returned first.

class CommListener extends Communications.ConnectionListener {
    function initialize() {
Communications.ConnectionListener.initialize();
    }

    function onComplete() {
    }

    function onError() {
        System.println("Transmit Failed");
    }
}

function     trans(type,tim,mess) {
var list = new CommListener();
var uit=[type,mess.size(),tim,mess];
	Communications.transmit(uit, null, list);
}
function     transbase(type,base,tim,mess) {
var list = new CommListener();
var uit=[type,base,mess.size(),tim,mess];
	Communications.transmit(uit, null, list);
}

function heartrate(starttime) {

if( !((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getHeartRateHistory))) {	return;	}
//var maxi=Math.ceil((Time.now().value()-starttime)/60);
var maxi=(Time.now().value()-starttime+59)/60;
if(maxi>360||maxi<1) {
	maxi=360;
	}
var options={:period => maxi};
var sensorIter = Toybox.SensorHistory.getHeartRateHistory(options);
	if(sensorIter)  {
		var uit=new[maxi];
		for(var enit=maxi-1; enit>=0 ;enit--) {
			var geg=sensorIter.next();
			if(geg == null) {
				trans(HEART,sensorIter.getNewestSampleTime().value(),uit.slice(enit+1, null));
				sensorIter=null;
				return;
				}
			uit[enit]=[geg.when.value(),geg.data];
			}
		trans(HEART,sensorIter.getNewestSampleTime().value(),uit);
		}
	}
