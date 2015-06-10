function printDiv(divName) {
    var printContents = document.getElementById(divName).innerHTML;
    var popupWin = window.open('', '_blank', 'width=device-width,height=device-height');
    popupWin.document.open()
    popupWin.document.write('<html></head><body onload="window.print()">' + printContents + '</html>');
    popupWin.document.close();
}