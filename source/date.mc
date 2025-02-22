using Toybox.Time;
using Toybox.Time.Gregorian;
class dayChange {
var val,today;
    function initialize(valin) {
    	val=valin;
	today = Gregorian.info(new Time.Moment(val[0]), Time.FORMAT_SHORT);
	}
function orig() {
	return today.day.format("%d");
	}
function storedata(numstr) {
	 var day=numstr.toNumber();
	if(day==null) {return false;}
	var bij=day-today.day;
	val[0]=val[0]+bij*24*60*60;
	return true;
	}
}
class yearChange {
var val;
    function initialize(valin) {
	val=valin;
	}
function orig() {
	var tim = Gregorian.info(new Time.Moment(val[0]) , Time.FORMAT_SHORT);
	return tim.year.format("%d");
	}
function storedata(numstr) {
 var year=numstr.toNumber();
if(year==null) {return false;}
if(year<39&&year>=0) {
	year+=2000;
	}
if(year<1970||year>2038) {
	return false;
	}
var date = Gregorian.utcInfo(new Time.Moment(val[0]), Time.FORMAT_SHORT);

var inmo=days(date.month-1,year);
if(date.day>inmo) {
	date.day=inmo;
	}
var options = {
    :year   => year,
    :month  => date.month, 
    :day    => date.day,
    :hour   => date.hour,
    :minute    => date.min,
   :second => date.sec
};
var dat = Gregorian.moment(options);
val[0]=dat.value();
return true;
	}
}
class hourChange {
var val;
var washour;
    function initialize(valin) {
	val=valin;
	}
function orig() {
	var tim = Gregorian.info(new Time.Moment(val[0]) , Time.FORMAT_SHORT);
	washour=tim.hour;
	return	washour.format("%02d");
	}
function storedata(numstr) {
 var hour=numstr.toNumber();
if(hour!=null&&hour>=0&&hour<=24) {
/*	var tijd=val[0]+zoneof;
	var onder=tijd%(3600);
	var boven=tijd/(3600*24);
	val[0]=onder+ (24*boven+hour)*3600-zoneof;
	*/
	val[0]+=(hour-washour)*60*60;
	return true;
	}
else {
	return false;
	}
	}
}
class minChange {
var val;
    function initialize(valin) {
	val=valin;
	}

function orig() {
	var tim = Gregorian.info(new Time.Moment(val[0]) , Time.FORMAT_SHORT);
	return	tim.min.format("%02d");
	}
function storedata(numstr) {
	 var min=numstr.toNumber();
if(min!=null&&min>=0&&min<130) {
	var tijd=val[0];
	var onder=tijd%60;
	var boven=tijd/3600;
	val[0]=onder+ (60*boven+min)*60;
	return true;
	}
else {return false;}
}
	
}
