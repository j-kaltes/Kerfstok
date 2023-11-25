using Toybox.Lang;
using Toybox.Application.Storage;
using Toybox.System;
using Toybox.Communications;
using Toybox.WatchUi;

var storageid=[0,0];
//const maxstorage=512;
//const maxstorage=10;
//var numget= 0;
//var numit=0;
const baseapart=maxstorage;



//function getstorageid(base) { return Storage.getValue(-1-base); }


function getstorageid(base) {
	return -base-1;
	}
function setstorageid(base,end) {
	storageid[base]=end;
	Storage.setValue(getstorageid(base),end);
	}


function storinit(base)  {
	var id=Storage.getValue(getstorageid(base));
	if(id) {
		storageid[base]=id;
		}
	else {
		storageid[base]=0;
		}
	}

function storageinit() {
	storinit(0);
	storinit(1);
	}
var lowestchange=[0,0];
function getlowestchange(base) {
	if(base==0) {
		return Storage.getValue("lowest");
		}
	else {
		return Storage.getValue("lowest1");
		}
	}
var oldlowest=[-1,-1];
function setlowestchange(base,id) {
	 oldlowest[base]=lowestchange[base];
	if(base==0) {
		 Storage.setValue("lowest",id);
		 lowestchange[base]=id;
		 }
	else {
		 Storage.setValue("lowest1",id);
		 lowestchange[base]=id;

	}
	}

function instorage(base,id) {
	return (id%maxstorage)+base*baseapart;
	}

function getval(base,id) {return Storage.getValue(instorage(base,id));}

function setval(base,id,dat) {
	if(id<lowestchange[base]) {
		setlowestchange(base,id);
		}
	 Storage.setValue(instorage(base,id),dat);
	}
function setval2(base,id,dat) {
	 Storage.setValue(instorage(base,id),dat);
	}
function delval(base,id) { 
	Storage.deleteValue(instorage(base,id));
	}
function putdata(base,begin,end,ar) {
var len=ar.size();
var list = new CommListener();
if((end-begin)!=len) {
	Communications.transmit([SENDERROR,PUTNUMS], null, list);
	return;
	}
for(var i=0,iter=begin;i<len;i++) {
	setval2(base,iter,ar[i]);iter++;
	}
var oldend=storageid[base];
if(end>oldend) {
	setstorageid(base,end);
	}
var lowest=lowestchange[base];
if(oldend<begin||(end-lowest)>maxstorage||(lowest>=begin&&lowest<end)) {
	setlowestchange(base,end);
	}
Communications.transmit([GOTNUMS,base,begin,end], null, list);

WatchUi.requestUpdate();
}

//clearValues
function clearnums() {
	Storage.clearValues();
	storageid[0]=0;
	storageid[1]=0;
	Storage.setValue(-1,storageid[0]);
	Storage.setValue(-2,storageid[1]);
	}
function moveondate(base,id,val) {
//	var val=getval(base,id);
	var tim=val[0];
	var grens=storageid[base]>maxstorage?storageid[base]-maxstorage:0;
	var old= id-1;
	var naar=id;
	var endupin;
	for(;old>=grens;old--) {
		var was=getval(base,old);
		if(was) {
			if(was[0]<=tim) {break;}
			setval(base,naar,was);
			naar=old;
			}
		}
	if(naar!=id) {
		setval(base,naar,val);
		endupin=naar;
		}
	else {
		old=id+1;
		naar=id;
		for(;old<storageid[base];old++){
			var was=getval(base,old);
			if(was) {
				if(was[0]>=tim) {break;}
				setval(base,naar,was);
				naar=old;
				}
			}
		endupin=naar;
		setval(base,naar,val);
		}
	return endupin;
	}

(:debug)function getlastnum(base) {
return lowestchange[base];
}
function setlastnum(base,num) {
	if(num>lowestchange[base]) {
		setlowestchange(base,num);
		}

}


//var precvars=[0.5,1,1,0.5,1,1,0.1,0,0];
function setvarnr() {
	varnr=(vars.size()<precvars.size())?vars.size():precvars.size();
	}
function putprec(ar) {
	if(ar!=null&&ar.size()>0) {
		precvars=ar;
		setvarnr() ;
		Storage.setValue("preclabels",precvars);
		}
	Communications.transmit([RECEIVEDPRECISION], null,  new CommListener());	
	}
function putlabels(ar) {
	if(ar!=null&&ar.size()>0) {
		vars=ar;
		setvarnr() ;
		Storage.setValue("labels",vars);
		}
	Communications.transmit([RECEIVEDLABELS], null,  new CommListener());	
	WatchUi.requestUpdate();
	}
var shortcuts=[];
function putcuts(ar) {
	Storage.setValue("shortcuts",ar);
	shortcuts=ar;	
	Communications.transmit([RECEIVEDCUTS], null,  new CommListener());	
	WatchUi.requestUpdate();
	}



function deletethrough(base,datanum) {
	delval(base,datanum);
	if(datanum==(storageid[base]-1)) {/*Wordt er dan wel duidelijk gemaakt dat data verwijdered is?*/
		var grens=storageid[base]>maxstorage?storageid[base]-maxstorage:0;
		var i=storageid[base]-2;
		for(;i>=grens&&getval(base,i)==null;i--) {
			}

	       setstorageid(base,i+1);
		return storageid[base];
		}
	return datanum;
	}
function delete(base,datanum) {
	var deldat=deletethrough(base,datanum);
	if(lowestchange[base]==null||deldat<lowestchange[base]) {
		setlowestchange(base,deldat);
		}

//	havenums(base);
	senddelete(base,datanum);

	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	}

function deletedsend(base,num)  {
	if(num==lowestchange[base]) {
		var old=oldlowest[base];	
		if(old>lowestchange[base]) {
			setlowestchange(base,old);
			}

		}
	}
