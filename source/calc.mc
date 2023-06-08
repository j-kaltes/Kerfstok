using Toybox.Lang;
using Toybox.System;
using Toybox.Math;


function parse(ops,lenin) {
if(lenin==0) {return null;}
if(lenin==1) {
		if(ops[0] has :abs) {
			return ops[0];
			}
		if(ops[0]==' '||ops[0]=='	'||ops[0]=='\n')	{return 0;}
		else  {return null;}
	}
else {
	if(lenin==2&&ops[0]=='-'&&ops[0] has :abs) {
		return -ops[0];
		}
	}
var len=lenin;

var uit=0;
var in;
for(in=1;in<(len-1);in++) {
	switch(ops[in]) {
		case '^': in++;if(!(ops[uit]  has :abs && ops[in] has :abs)) { return null;}
		
		ops[uit]=Math.pow(ops[uit],ops[in]);break;
		default: uit++;ops[uit]=ops[in];
		}
	}
if(in<len) {
	uit++;ops[uit]=ops[in];
	}

len=uit+1;
uit=0;
for(in=1;in<(len-1);in++) {
	switch(ops[in]) {
		case 'x':
		case '*': in++; if(!(ops[uit]  has :abs && ops[in] has :abs)) { return null;}
			ops[uit]=ops[uit]*ops[in];break;
		case '/' : in++; if(!(ops[uit]  has :abs && ops[in] has :abs)) { return null;}
			ops[uit]=ops[uit].toFloat()/ops[in];break;
		default: uit++;ops[uit]=ops[in];
		}
	}

if(in<len) {
	uit++;ops[uit]=ops[in];
	}
len=uit+1;
uit=0;
for(in=1;in<(len-1);in++) {
	switch(ops[in]) {
		case '+': in++; if(!(ops[uit]  has :abs && ops[in] has :abs)) { return null;}
			ops[uit]=ops[uit]+ops[in];break;
		case '-' : in++; if(!(ops[uit]  has :abs && ops[in] has :abs)) { return null;}
				ops[uit]=ops[uit]-ops[in];break;
		default: uit++;ops[uit]=ops[in];
		}
	}
if(in<len) {
	return null;
	}
return ops[0];	
}

function haken(ops) {
var lit=0;
var left=new[ops.size()/2+1];
var uit=0;

//haken(['(',5,'+',2,')','*',4,'-',2,'*',8]);
for(var i=0;i<ops.size();i++) {
	switch(ops[i]) {
		case '(':left[lit]=uit;lit++;break;
		case ')': 
			lit--; 
			if(lit<0) {return null;}
			var n;
			var neg=1;
			var uiter=left[lit];
			for(n=left[lit]-1;n>=0&&ops[n]=='-';n--) {
				neg=-1*neg;
				}
			if(n!=(left[lit]-1)) {
				if(n<0||!(ops[n] has :abs)) {
					uiter=n+1;
					}
				else {
					neg=1;
					}
				}
		 	var puit=parse(ops.slice(left[lit],uit),uit-left[lit]);
			if(puit==null) {return null;}	
			ops[uiter]=neg*puit;uit=uiter+1;break;
		default: ops[uit]=ops[i];uit++;
		}
	}
return parse(ops,uit);

}
const nopoint=99999;
function tokenize(chars,len) {
	var ar=[];
	var get=0;
	var point=nopoint;
	var was=0;
	var oper=1;
	var neg=1;
	for(var i=0;i<len;i++) {
		var el;
		for(;i<len;i++) {
			el=chars[i];
			if(el>='0'&&el<='9') {
				get=get*10+(el.toNumber()-48);
	//			get=get*10+(el-48);
				}
			else {
			   if(el=='.') {
				if(point!=nopoint) {
					return null;
					}
				point=i+1;
				}
			else {
				break;
				}
			
			}
			}
		  if(i!=was) {
			if(point!=nopoint&&i>point)  	{
				ar=ar.add(neg*get/Math.pow(10,(i-point)));
				}
			else {
				ar=ar.add(neg*get);
				}
			oper=0;
			neg=1;
		  	}
		for(;i<len;i++) {
			el=chars[i];
			if(!(el==' '||el=='	'||el=='\n')) {break;}
			}
		if(i<len) {
			if(el=='-'&&oper) {
				neg=-1*neg;
				}
			else {
				if(neg<0)  { ar=ar.add('-'); }
				 ar=ar.add(el);
				if(el==')') {
					oper=0;
					}
				else {
					oper=1;
					}
				neg=1;
				 }
			 get=0;
			 was=i+1;
			 point=nopoint;
			 }
		  }
	return ar;
	}

function calc(ar,len) {
return haken(tokenize(ar,len));
	}
