function mapLegend(canvas) {

    var ctx = canvas.getContext("2d");
  //  ctx.fillRect(10, 10, 10, 10

    var canvasHeight=350;

    if (screen.height<400) {
        canvasHeight = screen.height * 0.6;
        canvas.height = canvasHeight;
    }

    ctx.font="15px Georgia";
    ctx.fillText("0",0,20);
    ctx.fillText("20",0,120);

    var my_gradient=ctx.createLinearGradient(0,0,0,canvasHeight-20);
    my_gradient.addColorStop(0,"red");
    my_gradient.addColorStop(0.2,"orange");
    my_gradient.addColorStop(0.4,"yellow");
    my_gradient.addColorStop(0.6,"green");
    my_gradient.addColorStop(0.8,"blue");
    my_gradient.addColorStop(1,"purple");
    ctx.fillStyle=my_gradient;
    ctx.fillRect(20,20,100,canvasHeight-20);
}