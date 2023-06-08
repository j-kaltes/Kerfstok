using Toybox.Activity;
using Toybox.Time;
using Toybox.Time.Gregorian;

function infofunc(info,num) {
   switch(num) {
      case 0: 
	if( info has :maxSpeed&& info.maxSpeed!=null) {
		return (info.maxSpeed*toshowspeed).format("%.0f");
		}
	else {
		return null;
		}
      case 1: 
	if( info has :averageSpeed&& info.averageSpeed!=null) {
		return (info.averageSpeed*toshowspeed).format("%.0f");
		}
	else {
		return null;
		}
      case 2: 
	if( info has :startTime&&info.startTime!=null) {
		var tim = Gregorian.info(info.startTime , Time.FORMAT_SHORT);
//		return tim.hour+":"+tim.min+":"+tim.sec;
//s/\(\<[a-z]*\>\.format\)/tim\.\1/g
		return tim.hour.format("%02d")+":"+tim.min.format("%02d")+":"+tim.sec.format("%02d");
		}
	else {
		return null;
		}
      case 3: 
	if( info has :elapsedTime&&info.elapsedTime!=null) {
		return (info.elapsedTime/1000.0).format("%.0f");
		}
	else {
		return null;
		}
		/*
      case 4: 
	if( info has :timerTime&&info.timerTime!=null) {
		return (info.timerTime/1000.0).format("%.0f");

		}
	else {
		return null;
		}
		*/
      case 4: 
	if( info has :currentOxygenSaturation) {
		return info.currentOxygenSaturation;
		}
	else {
		return null;
		}
      case 5: 
	if( info has :averageHeartRate) {
		return info.averageHeartRate;
		}
	else {
		return null;
		}
      case 6: 
	if( info has :maxHeartRate) {
		return info.maxHeartRate;
		}
	else {
		return null;
		}
      case 7: 
	if( info has :energyExpenditure&& info.energyExpenditure!=null) {
		return info.energyExpenditure.format("%.0f");
		}
	else {
		return null;
		}
      case 8: 
	if( info has :calories) {
		return info.calories;
		}
	else {
		return null;
		}
      case 9: 
	if( info has :frontDerailleurIndex) {
		return info.frontDerailleurIndex;
		}
	else {
		return null;
		}
      case 10: 
	if( info has :frontDerailleurMax) {
		return info.frontDerailleurMax;
		}
	else {
		return null;
		}
      case 11: 
	if( info has :frontDerailleurSize) {
		return info.frontDerailleurSize;
		}
	else {
		return null;
		}
      case 12: 
	if( info has :rearDerailleurIndex) {
		return info.rearDerailleurIndex;
		}
	else {
		return null;
		}
      case 13: 
	if( info has :rearDerailleurMax) {
		return info.rearDerailleurMax;
		}
	else {
		return null;
		}
      case 14: 
	if( info has :rearDerailleurSize) {
		return info.rearDerailleurSize;
		}
	else {
		return null;
		}
      case 15: 
	if( info has :currentPower) {
		return info.currentPower;
		}
	else {
		return null;
		}
      case 16: 
	if( info has :averagePower) {
		return info.averagePower;
		}
	else {
		return null;
		}
      case 17: 
	if( info has :maxPower) {
		return info.maxPower;
		}
	else {
		return null;
		}
      case 18: 
	if( info has :currentCadence) {
		return info.currentCadence;
		}
	else {
		return null;
		}
      case 19: 
	if( info has :averageCadence && info.averageCadence!=null) {
		return info.averageCadence*2;
		}
	else {
		return null;
		}
      case 20: 
	if( info has :maxCadence&&info.maxCadence!=null) {
		return info.maxCadence*2;
		}
	else {
		return null;
		}
      case 21: 
	if( info has :bearing) {
		return info.bearing;
		}
	else {
		return null;
		}
      case 22: 
	if( info has :bearingFromStart) {
		return info.bearingFromStart;
		}
	else {
		return null;
		}
      case 23: 
	if( info has :totalAscent&& info.totalAscent!=null) {
		return info.totalAscent.format("%.1f");
		}
	else {
		return null;
		}
      case 24: 
	if( info has :totalDescent&& info.totalDescent!=null) {
		return info.totalDescent.format("%.1f");
		}
	else {
		return null;
		}
      case 25: 
	if( info has :meanSeaLevelPressure&&info.meanSeaLevelPressure!=null) {
		return info.meanSeaLevelPressure.format("%.0f");
		}
	else {
		return null;
		}
      case 26: 
	if( info has :ambientPressure&&info.ambientPressure!=null) {
		return info.ambientPressure.format("%.0f");
		}
	else {
		return null;
		}
      case 27: 
	if( info has :rawAmbientPressure&&info.rawAmbientPressure!=null) {
		return info.rawAmbientPressure.format("%.0f");
		}
	else {
		return null;
		}
      case 28: 
	if( info has :currentHeading) {
		return info.currentHeading;
		}
	else {
		return null;
		}
   }
	return null;
}

var infostr=[
"maxSpeed",
"averageSpeed",
"startTime",
"elapsedTime",
"OxygenSaturation",
"averageHeartRate",
"maxHeartRate",
"energyExpenditure (kcals/min)",
"calories (kcal)",
"frontDerailleurIndex",
"frontDerailleurMax",
"frontDerailleurSize",
"rearDerailleurIndex",
"rearDerailleurMax",
"rearDerailleurSize",
"Power",
"averagePower",
"maxPower",
"Cadence (steps/min)",
"averageCadence",
"maxCadence",
"bearing",
"bearingFromStart",
"totalAscent",
"totalDescent",
"meanSeaLevelPressure",
"ambientPressure",
"rawAmbientPressure",
"Heading",
];
