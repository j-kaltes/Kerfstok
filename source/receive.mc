using Toybox.Communications;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application.Properties as Prop;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.FitContributor as Fit;
/*
function putlabels(ar) {
vars=new [ar.size()];
var i=0;
	for(i=0;i<ar.size();i++) {
		var val= i+1;
		Prop.setValue("var"+val,ar[i]);
		vars[i]=ar[i];
		}
	for(;i<varnr;i++) {
		var val= i+1;
		Prop.setValue("var"+val,"");
			}
varnr=vars.size();
WatchUi.requestUpdate();
	}
var displaystr="";
function showsend(num) {
	displaystr=num;
	WatchUi.requestUpdate();
	}
	
*/
var glucosestr="";
function setglucose(gegs) {
	if(!(gegs has :size)||gegs.size()<5) {
		return;
		}
	sensorversion=gegs[0];
	glucosetime=gegs[1];
	var glucose=gegs[2];
	if(gegs.size()==6) {
		glunits=(gegs[5]==1)?1:0;
		}
	if(glunits==1) {
		glucosestr=glucose.format("%.1f");
		}
	else {
		glucosestr=glucose.format("%.0f");
		}
	var alarm=gegs[4];
	var nooff=alarm&0x07;
	if((alarm&0x08)!=0x0)  {
		if(alarm&0x10!=0x0) {
			startalarm();
			}
		else {
			clearbeep();
			clearbeep();
			clearbeep();
			clearbeep();
			}
		}
	switch(nooff) {
		case 4:glucoserate=20.0;break;
		case 5:glucoserate=-20.0;break;
		default: glucoserate=gegs[3];break;
		}
	//TODO don't add when too old
	if(glufield!=null) {
		var unixnu=Time.now().value();
		if((unixnu-glucosetime)<30) {
			glufield.setData(glucose);
			}
		}
	WatchUi.requestUpdate();
	return;
	}

//var glformat;
function setglunit(num) {
	if(num==1) {
		glunits=1;
//		glformat= "%.1f";
		}
	else {
		glunits=0;
//		glformat= "%.0f";
		}
	}
function mkglunit(num) {
	setglunit(num);
	Communications.transmit([RECEIVEDUNITS], null,  new CommListener());	
	}



function sendendnum(base) {
	if(base>=0&&base<2) {
		 Communications.transmit([SETENDNUM,base, storageid[base]],null, new CommListener());	
		 }
	 }
function setendhere(base,num) {
	if(base>=0&&base<2) {
		if(num<storageid[base]) {
			setstorageid(base,num) ;
			}
		}
	Communications.transmit([DIDSETENDNUM], null,  new CommListener());	
	}
function oninput(data) {
if(data instanceof Toybox.Lang.Array&&data.size()>0) {
	var key=data[0];
	switch(data.size()) {
		case 1:
			switch(key) {
			  case START: startglucose() ;return;
			  case STOPALARM: 
			  	alarmactive=false;
				Communications.transmit([GOTSTOPALARM], null,  new CommListener());	
				  return;
			  default : System.println("Key "+key);return;
			  }
			  break;
		case 2: {
			var num=data[1];
			switch(key) {

				case COLORBLACK:  receivecolor(num);return;
				case GLUNITS:  mkglunit(num);return;
				case GLUCOSE:  setglucose(num);
					gotglucose();
					return;
				case HEART: heartrate(num);return;
				case PUTLABELS:  putlabels(num);return;
				case PUTPRECISION:  putprec(num);return;
				case SHORTCUTS:  putcuts(num);return;
				case GETENDNUM:  sendendnum(num);return;
				default:	 System.println("Key "+key+" num "+num);return;
				}
			}
			break;
		case 3: {
			var base=data[1];
			var num2=data[2];
			switch(key) {
				case NUMS:  numdata(base,num2);return;
				case SETENDNUM:  setendhere(base,num2) ;return;
				case MORENUMS:setlastnum(base,num2); numdata(base,num2);return;
				case DELETED:deletedsend(base,num2);return;
				default: System.println("Key="+key+" base="+base+" num2="+num2);return;
				}
			}
			break;
		case 4: 
			switch(key) {
				case DELETE:netdelete(data[1],data[2],data[3]) ;return;
				}
			
			break;
		case 5: 
			switch(key) {
				case PUTNUMS:  putdata(data[1],data[2],data[3],data[4]);return;
				default: return;
				}
			
		default:
			 System.println("len="+data.size());return;
		}
	}
else {
	switch(data) {
		case LABELS:trans(LABELS,Time.now().value(),vars.slice(0,varnr));break;
		case CLEAR: clearnums();break;
		default: {
			System.println("Wrong message");
			break;
			}
			}

	}
	}

