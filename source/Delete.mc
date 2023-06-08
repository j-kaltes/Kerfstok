
using Toybox.WatchUi;
class DeleteConfirmationDelegate extends WatchUi.ConfirmationDelegate {
var base;
var datanum;

    function initialize(basein,dat) {
        ConfirmationDelegate.initialize();
	base=basein;
	datanum=dat;
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_YES) {
		delete(base,datanum);
        }
    }
}

