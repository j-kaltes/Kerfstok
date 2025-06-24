using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.System;
using Toybox.Application.Storage;
import Toybox.Lang;
const maxtransmit=50; //100 gives Error: Out Of Memory Error
function sendnums(type as Number,base as Number,num as Number) as Void {
    if(lowestchange[base]==null) {
        asklowest();
        return;
        }
    if(num>lowestchange[base]) {
        num=lowestchange[base];
        }
    var iter= storageid[base];
    if(num>=iter) {
        Communications.transmit([NOMORENUMS,base,iter], null,  new CommListener());	
        return;
        }
    var len=iter-num;
    if(len>maxstorage) {
        len=maxstorage;
        num=iter-len;
        }
    if(len>maxtransmit) {
        len=maxtransmit;
        }
    var data=new[len];
    var it=num;
    for(var i=0;i<len;it++,i++) {
        data[i]=getval(base,it);
        }
    transbase(type,base,it,data);
}

function numdata(base as Number ,num as Number) as Void {
	sendnums(NUMS,base,num);
	}
function numdataone(base as Number,num as Number) as Void{
      if(base==0&&lowestchange[0]==null) {
            lowestchange[0]=num;
            }
	sendnums(NUMS,base,num);
	}

function havenums(base as Number) as Void{
	sendnums(HAVENUMS,base,lowestchange[base]);
	}
var glucoactive=false;

function 	asklowest() as Void{
	//Communications.transmit([ASKLOWEST], null,  new CommListener());	
	//Communications.transmit([START,true], null,  new CommListener());	
	if(!glucoactive) {
 	    startglucose();
        }
	}
function 	startglucose() as Void{
	Communications.transmit([START,lowestchange[0]==null], null,  new CommListener());	
	glucoactive=true;
	}
function 	gotglucose() {
	if(!glucoactive) {
	 	startglucose();
		}
	else  {
		Communications.transmit([GOTGLUCOSE], null,  new CommListener());	
		}
		
	}

function 	stopglucose() {
	if(glucoactive) {
		Communications.transmit([STOP], null,  new CommListener());	
		glucoactive=false;
		}
	}


function senddelete(base as Number,pos as Number) as Void {
	 Communications.transmit([DELETE,base,pos],null, new CommListener());	
	 }


function netdelete(base as Number,num as Number,end as Number) as Void  {
var last=end-1;
for(var it=num;it<last;it++) {
	delval(base,it);
	}
 deletethrough(base,last);
 Communications.transmit([DELETED,base,num,end],null, new CommListener());	
  WatchUi.requestUpdate();
}	

function stopalarm() {
	alarmactive=false;
	Communications.transmit([STOPALARM], null,  new CommListener());
	}
