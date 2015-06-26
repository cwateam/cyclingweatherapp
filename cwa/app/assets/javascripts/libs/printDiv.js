// Function opens a new window that has only the content of given html div
// and tries to open a print window for that content.
// Used here to print the directions.

function printDiv(divName) {
    var printContents = document.getElementById(divName).innerHTML;
    var popupWin = window.open('', '_blank',  'width=auto,height=auto,scrollbars=1');
    popupWin.document.open();
    popupWin.document.write('<html></head><body onload="window.print()">' + printContents + '</html>');
    popupWin.document.close();
}