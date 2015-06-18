function mapLegend(canvas) {

    var ctx = canvas.getContext("2d");
  //  ctx.fillRect(10, 10, 10, 10

    ctx.rect(20,20,150,100);
    ctx.fillStyle="white";
    ctx.fill();


    var my_gradient=ctx.createLinearGradient(0,0,0,300);
    my_gradient.addColorStop(0,"red");
    my_gradient.addColorStop(0.2,"orange");
    my_gradient.addColorStop(0.4,"yellow");
    my_gradient.addColorStop(0.6,"green");
    my_gradient.addColorStop(0.8,"blue");
    my_gradient.addColorStop(1,"purple");
    ctx.fillStyle=my_gradient;
    ctx.fillRect(20,20,100,300);
}