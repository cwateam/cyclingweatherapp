function printDiv(divName) {
    var printContents = document.getElementById(divName).innerHTML;
    var popupWin = window.open('', '_blank',  'width=auto,height=auto,scrollbars=1');
    popupWin.document.open()
    popupWin.document.write('<html></head><body onload="window.print()">' + printContents + '</html>');
    popupWin.document.close();
}