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

var initer=null;
var venusq=false;
var venu=false;
var venusq2=false;
var fenix7=false;
var marq2=false;
var edgeexplore2=false;
var edge830=false;
var fr965=false;
class TakeNumApp extends Application.AppBase {
    private var methodmail as Method(mailIter as  MailboxIterator) as Void;
//    private var methodphone     as Method(msg as Message) as Void;
    private var methodphone     as Method(msg as PhoneAppMessage) as Void;



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
	    methodphone=method(:onPhone);
	    Communications.registerForPhoneAppMessages(methodphone);
	   } 	
	   else {
		if(Communications has :setMailboxListener) {
			System.println("setMailboxListener");
			methodmail= method(:onMail);
			Communications.setMailboxListener(methodmail);
			} 
		}
	   System.println("end initmessages");
	}

//    function onPosition(info) { }

function initialize() {
        AppBase.initialize();
	if(WatchUi.loadResource(Rez.Strings.venusq).equals("y")) {
		venusq=true;
		}
	else {
		if(WatchUi.loadResource(Rez.Strings.venusq2).equals("y")) {
			venusq2=true;
			}
		else {
			if(WatchUi.loadResource(Rez.Strings.venu).equals("y")) {
				venu=true;
				}
			else {
				if(WatchUi.loadResource(Rez.Strings.fenix7).equals("y")) {
					fenix7=true;
					}
				else {
					if(WatchUi.loadResource(Rez.Strings.marq2).equals("y")) {
						marq2=true;
						}
					else {
						if(WatchUi.loadResource(Rez.Strings.edgeexplore2).equals("y")) {
							edgeexplore2=true;
							histrows=7;
							}
						else {
							if(WatchUi.loadResource(Rez.Strings.edge830).equals("y")) {
								edge830=true;
								}
							else {
								if(WatchUi.loadResource(Rez.Strings.fr965).equals("y")) {
									fr965=true;
									}
								}
							}
						}
					}
				}
			}
		}
//	venu=true;

	initer =new init();
	initer.initall();
	initmessages();
    }




    function onStop(state) {
    	stopglucose();
//	sportsave();
	Storage.setValue("glunits",glunits);
    	for(var i=0;i<numset.size();i++) {
		var nr=numset[i];
		if(memnum[nr].size()) {
			Storage.setValue("memnum"+nr,StringUtil.charArrayToString(memnum[nr]));
			}
		else {
			Storage.deleteValue("memnum"+nr);
			}
		}
    }

//Er wordt vaak een GPS schermpje getoond bij starten of stoppen app. En de batterij gaat snel op.
 
function getInitialView() {
//	Position.enableLocationEvents(Position.LOCATION_DISABLE,null);
	return [new EmptyView(), new EmptyDelegate()];
    }



	



}
