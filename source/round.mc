using Toybox.Math;
function round(val, prec) {
	if(prec<0.00001) {
		return val;
		}
	return Math.round(val/prec)*prec;		
	}
