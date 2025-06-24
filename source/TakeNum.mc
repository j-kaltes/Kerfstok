import Toybox.Application;
import Toybox.Communications;
import Toybox.Lang;
import Toybox.System;

using Toybox.StringUtil;
using Toybox.Application.Storage;
using Toybox.Position;



function receivecolor(num) {
   Storage.setValue("reversecolor",num);
   setcolor(num);
   Communications.transmit([COLORBLACK], null,  new CommListener());   
   }
function ackReceived() {
   Communications.transmit([COLORBLACK], null,  new CommListener());   
   }

var selected=-1;

var initer=null;
var venusq=false;
var venu=false;
var venusq2=false;
var fenix7=false;
var fenix8=false;
var fenixe=false;
var marq2=false;
var edgeexplore2=false;
var edge1040=false;
var edge830=false;
var edge840=false;
var fr965=false;
var fr165=false;
var mk3=false;
var mk2=false;
var instinct3=false;
var venux1=false;
var vivoactive6=false;
var fr735xt=false;
var fr935=false;
var fr55=false;
var fr570=false;
class TakeNumApp extends Application.AppBase {
    private var methodmail as Method(mailIter as  MailboxIterator) as Void = method(:onMail);
    private var methodphone     as Method(msg as PhoneAppMessage) as Void = method(:onPhone);



    public function onMail(mailIter as MailboxIterator) as Void {
        var mail = mailIter.next();

        while(mail != null) {
      oninput(mail);
            mail = mailIter.next();
        }

        Communications.emptyMailbox();
        WatchUi.requestUpdate();
    }

    public function onPhone(msg as PhoneAppMessage) as Void {
        var data = msg.data;
   oninput(data);
        WatchUi.requestUpdate();
    }
function initmessages() {
   if(Communications has :registerForPhoneAppMessages) {
      System.println("registerForPhoneAppMessages");
      // methodphone=method(:onPhone);
       Communications.registerForPhoneAppMessages(methodphone);
      }    
      else {
      if(Communications has :setMailboxListener) {
         System.println("setMailboxListener");
       //  methodmail= method(:onMail);
         Communications.setMailboxListener(methodmail);
         } 
      }
      System.println("end initmessages");
   }

//    function onPosition(info) { }

function watchversions() {
   if(WatchUi.loadResource(Rez.Strings.venusq).equals("y")) {
      venusq=true;
      return;
      }
  if(WatchUi.loadResource(Rez.Strings.venusq2).equals("y")) {
     venusq2=true;
     return;
     }
 if(WatchUi.loadResource(Rez.Strings.venu).equals("y")) {
    venu=true;
    return;
    }
if(WatchUi.loadResource(Rez.Strings.fenix7).equals("y")) {
   selected=2;
   fenix7=true;
   return;
   }
   if(WatchUi.loadResource(Rez.Strings.marq2).equals("y")) {
      marq2=true;
      selected=2;
      return;
      }
  if(WatchUi.loadResource(Rez.Strings.edgeexplore2).equals("y")) {
     edgeexplore2=true;
     histrows=7;
     return;
     }

 if(WatchUi.loadResource(Rez.Strings.edge830).equals("y")) {
    histrows=5;
    edge830=true;
    return;
    }
    if(WatchUi.loadResource(Rez.Strings.fr965).equals("y")) {
       selected=2;
       fr965=true;
       return;
       }
   if(WatchUi.loadResource(Rez.Strings.mk3).equals("y")) {
        mk3=true;
        selected=2;
        return;
        }
   if(WatchUi.loadResource(Rez.Strings.fenix8).equals("y"))   {
       selected=2;
       fenix8=true;
       return;
       }
   if(WatchUi.loadResource(Rez.Strings.fenixe).equals("y"))   {
       selected=2;
       fenixe=true;
       return;
       }
   if(WatchUi.loadResource(Rez.Strings.edge1040).equals("y"))   {
       edge1040=true;
       histrows=8;
       return;
       }
   if(WatchUi.loadResource(Rez.Strings.edge840).equals("y"))   {
       histrows=5;
       edge840=true;
       edge830=true;
       return;
       }
   if(WatchUi.loadResource(Rez.Strings.fr165).equals("y"))   {
       selected=2;
       fr965=true;
       fr165=true;
       return;
       }
   if(WatchUi.loadResource(Rez.Strings.venux1).equals("y"))   {
       venux1=true;
       venusq2=true;
       histrows=5;
       return;
    }
   if(WatchUi.loadResource(Rez.Strings.vivoactive6).equals("y"))   {
       vivoactive6=true;
       fenixe=true;
       return;
       }
   if(WatchUi.loadResource(Rez.Strings.fr735xt).equals("y"))   {
       selected=2;
       fr735xt=true;
        }
   if(WatchUi.loadResource(Rez.Strings.fr935).equals("y"))   {
       selected=2;
       fr935=true;
        }
   if(WatchUi.loadResource(Rez.Strings.fr55).equals("y"))   {
       selected=2;
       fr55=true;
        }
   if(WatchUi.loadResource(Rez.Strings.fr570).equals("y"))   {
       selected=2;
       fr570=true;
        }
   if(WatchUi.loadResource(Rez.Strings.mk2).equals("y")) {
        mk2=true;
        selected=2;
        return;
        }
   if(WatchUi.loadResource(Rez.Strings.instinct3).equals("y")) {
        instinct3=true;
        selected=2;
        return;
        }
    }
function initialize() {
    AppBase.initialize();

    watchversions();
   initer =new init();
   initer.initall();
   initmessages();
    }




    function onStop(state) {
       stopglucose();
   Storage.setValue("glunits",glunits);
   if(initer==null) {
        return;
        }
   for(var i=0;i<numset.size();i++) {
      var nr=numset[i];
      if(memnum[nr].size()) {
         Storage.setValue("memnum"+nr, StringUtil.charArrayToString(memnum[nr]));
         }
      else {
         Storage.deleteValue("memnum"+nr);
         }
      }
    }

//Er wordt vaak een GPS schermpje getoond bij starten of stoppen app. En de batterij gaat snel op.
 
function getInitialView() {
//   Position.enableLocationEvents(Position.LOCATION_DISABLE,null);
   return [new EmptyView(), new EmptyDelegate()];
    }



   



}
