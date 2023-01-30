using Toybox.Application.Storage;
var nextsport,splen,prevsport;
function readsports() {
	var so=Storage.getValue("sportsort");
	splen=sports.size();
	if(so==null||!(so instanceof Toybox.Lang.Array)) {
		var len=splen;
		var n=new [len+1],p=new [len+1];	
		for(var i=0;i<(len-1);i++) {
			n[i]=i+1;
			p[i+1]=i;
			}
		p[0]=len;
		n[len-1]=len;
		n[len]=0;
		nextsport=n;
		prevsport=p;
		tofront(2);
		}
	else {
		nextsport=so[0];
		prevsport=so[1];
		}
	}

var sportschanged=false;
function	sportsave() {
	if(sportschanged) {
		var tosave=[nextsport,prevsport];
		Storage.setValue("sportsort",tosave);
		sportschanged=false;
		}
	}
function tofront(one) {
	var start=nextsport[splen];
	if(start==one) {
		return;
		}
	nextsport[splen]=one;

	var prev=prevsport[one];
	var nextprev=nextsport[one];
	nextsport[prev]=nextprev;

	prevsport[nextprev]=prev;

	prevsport[start]=one;
	nextsport[one]=start;

	prevsport[one]=splen;
	sportschanged=true;
	}

