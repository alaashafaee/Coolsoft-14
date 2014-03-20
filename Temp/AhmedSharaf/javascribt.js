 var Image_slide = new Array("../Images/Story03.png", "../Images/Story04.png", "../Images/Story05.png", "../Images/Story06.png", "../Images/Story07.png", "../Images/Story08.png", "../Images/Story09.png", "../Images/Story10.png", "../Images/Story11.png","../Images/Story12.png");
         var Img_Length = Image_slide.length;
         var Img_current = 0

         function slide() {
             if (Img_current >= Img_Length) {
                 Img_current = 0;
             }
             document.slideshow.src = Image_slide[Img_current];
             Img_current++;
         }
         function auto() {
             setInterval(slide, 3500);
         }
         window.onload = auto;