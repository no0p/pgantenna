$(window).scroll(function (event) {
    var scroll = $(window).scrollTop();
    if (scroll != 0) {
      opace = Math.min(Math.pow((scroll / 800.0), 4), 1);

			if (opace == 1) {
			  $(".navbar").css("border-bottom", "3px solid");
			} else {
			  $(".navbar").css("border-bottom", "0px");
			}

    	$(".navbar").css("background-color", "rgba(248, 248, 248, " + opace.toString() + ")");
    	$(".navbar").css("border-color", "#e7e7e7");
    	
    } else {
      $(".navbar").css("background-color", "transparent");
      
    }
});
