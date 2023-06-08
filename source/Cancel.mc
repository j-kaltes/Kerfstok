
using Toybox.WatchUi;
class CancelConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_YES) {
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		}
    }
}

