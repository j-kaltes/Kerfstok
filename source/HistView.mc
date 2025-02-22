using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.Time;
using Toybox.Time.Gregorian;
var showiter0;
var showiter1;
var minimum=[0,0];
var shown;
var shownbase;
var maxshown;
var item0,item1;
var histrows=4;

class HistView extends WatchUi.View {
const space="                                                        ";

var nonsense=[0,0,0];
var hmid;
var higher;
var fontvalue= (edge1040||edge840)?Gfx.FONT_GLANCE_NUMBER:((edgeexplore2||edge830)?Gfx.FONT_MEDIUM:Gfx.FONT_TINY);

var fonttimedate= (edge1040||edge840)?Gfx.FONT_GLANCE_NUMBER:(edgeexplore2?Gfx.FONT_SMALL:(edge830?Gfx.FONT_SMALL:Gfx.FONT_XTINY));

const valueheight=(edgeexplore2||edge840||fr165)?clockhight*.9:
((edge1040||venusq||venusq2)?clockhight*.8:
(edge830?clockhight*.7:clockhight*.85));
//const valueheight=clockhight;
//var space="                ";
    function initialize() {
        View.initialize();
    shown=new[histrows];
     shownbase=new[histrows];
    showiter0=storageid[0]-1;
    showiter1=storageid[1]-1;
    higher=(venusq2)?(height*0.0357):((edgeexplore2||edge1040)?(height*0.029):(edge830?height*0.06:
(venusq?(height*0.03):0.0)));
//    higher=venusq2?(height*0.055):0.0;
     hmid=(height-clockhight)*(((venusq||venusq2)?0.03:((edgeexplore2||edge1040)?0.01:(edge830?0.03:0.0)))+(1.0/(histrows+1)));
//     hmid=(height-clockhight)*(((edge1040||venusq2)?0.05:0.0)+(1.0/(histrows+1)));
    //higher=0.0;
 //    hmid=(height-clockhight)*(1.0/(histrows+1));

    }

 function onLayout(dc) {
   }

function onShow() {
     minimum[0]=(storageid[0]>maxstorage)?(storageid[0]-maxstorage):0;
     minimum[1]=(storageid[1]>maxstorage)?(storageid[1]-maxstorage):0;
    }



function onUpdate(dc) { 
    dc.clearClip();
    dc.setColor(foreground, background);
    dc.clear();
    var myTime = System.getClockTime(); // ClockTime object
    dc.drawText(wmid,clockhight , clockfont,    myTime.hour.format("%02d") + ":" + myTime.min.format("%02d"),Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_CENTER );

    var olddag=null;

    item0=showiter0;
    item1=showiter1;
    if(item1>=storageid[1])     {
        item1=storageid[1]-1;
        }
    var i;    
    for(i=0;i<histrows;i++) {
        var utime0=0,utime1=0;
        var val,val0=nonsense,val1=nonsense;
        while(item0>=minimum[0]) {
            val0=getval(0,item0);
            if(val0!=null) {
                utime0=val0[0];
                break;
                }
            item0--;
            }
        while(item1>=minimum[1]) {
            val1=getval(1,item1);
            if(val1!=null) {
                utime1=val1[0];
                break;
                }
            item1--;
            }

        if(utime1==0&&utime0==0) {
            break;
            }
     if(utime0<utime1) {
         shown[i]=item1;
        shownbase[i]=1;
         val=val1;
        item1--;
         }
    else {
         shown[i]=item0;
        shownbase[i]=0;
         val=val0;
        item0--;
         }
    if(val&&val[2]>=0&&val[2]<varnr) {
       var vartype=val[2]; 
        switch(vartype) {
            case 0: dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_WHITE);break;
            case 1: dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);break;
            case 2: dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_RED);break;
            case 3: dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);break;
            case 4: dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_BLUE);break;
            case 5: dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);break;
            case 6: dc.setColor(Gfx.COLOR_DK_BLUE, Gfx.COLOR_WHITE);break;
            case 7: dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_BLACK);break;
            case 8: dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_WHITE);break;
            case 9: dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_ORANGE);break;
            case 10: dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_WHITE);break;
            case 11: dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);break;
            case 12: dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_BLACK);break;
            case 13: dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_WHITE);break;
            case 14: dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_WHITE);break;
            case 15: dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_WHITE);break;
            case 16: dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);break;
            case 17: dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_WHITE);break;
            case 18: dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_PURPLE);break;
            case 19: dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_BLACK);break;
            default: dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
            }

    var tim=new Time.Moment(val[0]);
    var daginf = Gregorian.info(tim, Time.FORMAT_SHORT);
    //    var dag=(val[0]+zoneof)/(60*60*24);
            dc.drawText(wmid, hmid*(i+1)+2*valueheight-higher, fontvalue,space+vars[vartype]+" "+val[1].format("%g")+space,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
            if(olddag!=null&&(olddag.day==daginf.day&&olddag.year==daginf.year&&daginf.month==olddag.month)) {
                dc.drawText(wmid, hmid*(i+1)-valueheight-higher, fonttimedate,space+daginf.hour.format("%02d") + ":" + daginf.min.format("%02d")+space,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
                
                }
            else {
                dc.drawText(wmid, hmid*(i+1)-valueheight-higher, fonttimedate,space+daginf.hour.format("%02d") +":"+ daginf.min.format("%02d")+" "+daginf.day+"-"+months[daginf.month-1]+"-"+daginf.year+space,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
    //            dc.drawText(wmid, hmid*(i+1)-valueheight-higher, fonttimedate,space+datestr(tim)+space,Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );
            olddag=daginf;
            }
        }
        else {
            dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_PURPLE);
            dc.drawText(wmid, hmid*(i+1)+valueheight-higher, fontvalue,"Deleted",Gfx.TEXT_JUSTIFY_VCENTER| Gfx.TEXT_JUSTIFY_CENTER );

            }
        }

    maxshown=i;
    }

}
