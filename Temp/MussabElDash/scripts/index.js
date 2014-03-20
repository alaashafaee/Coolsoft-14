      $.wait = function( callback, seconds){
     		return window.setTimeout( callback, seconds * 1000 );
  	   }
        $(function(){
          togbgview();
          toggleVisibility(document.getElementById("aboutme"));
          var img = document.getElementById("adultimg");
          loadimg(img);
          bgorange();
          $('#adultimg').effect("bounce", { times:4 , distance:200 } , 1500);
        });

        function loadimg(x){
          var dh = Math.round(getDocHeight()/2.0) , dw = Math.round(getDocWidth()/2.0);
          var img = $(x);
          var h = Math.round(x.height/2.0) , w = Math.round(x.width/2.0);
          var le = dw - w , to = dh - h;
          img.offset({left:le , top:to});
          var ab = document.getElementById("aboutme");
          var abo = $(ab);
          var abw = Math.round(ab.width/2.0);
          var lefto = dw - abw , topo = abo.offset().top;
          abo.offset({left:lefto , top:topo});
        }

        function togbgview(){
            toggleVisibility(document.getElementById("bgextended"));
            toggleVisibility(document.getElementById("bgwhite"));
            toggleVisibility(document.getElementById("bgorange"));
            toggleVisibility(document.getElementById("bggreen"));
            toggleVisibility(document.getElementById("bgblack"));
        }
        
        function toggleVisibility(element){
          if(element.style.visibility == 'hidden')
            element.style.visibility = 'visible';
          else
            element.style.visibility = 'hidden';
        	// $(element).fadeToggle('fast');
        }
        
        function bgwhite(){
        	document.body.style.backgroundColor="#FFFFFF";
        }
        function bgorange(){
        	document.body.style.backgroundColor="#FFA916";
        }
        function bggreen(){
        	document.body.style.backgroundColor="#00FF00";
        }
        function bgblack(){
        	document.body.style.backgroundColor="#000000";
        }

        function getDocHeight(){
          return Math.max($(document).height(), $(window).height());
        }

        function getDocWidth(){
          return Math.max($(document).width(), $(window).width());
        }
        
        function adultimglocation(){
        	var img = document.getElementById("adultimg");
          var x = $(img);
          if(x.is(':animated'))
            return;
          var gmail = document.getElementById("gmailicon");
          var linkedin = document.getElementById("linkedinicon");
          toggleVisibility(document.getElementById("aboutme"));
          if(isCentered(img)){
            // alert("centered");
              var w = getDocWidth() - img.width;
              var lo = x.offset().left , to = x.offset().top;
              var dx = w - lo , dy = -to;
              // img.style.webkitTransform = "translate(" + dx + "px," + dy + "px) rotate(360deg)";
              // img.style.MozTransform = "translate(" + dx + "px," + dy + "px) rotate(360deg)";
              // img.style.msTransform = "translate(" + dx + "px," + dy + "px) rotate(360deg)";
              // img.style.oTransform = "translate(" + dx + "px," + dy + "px) rotate(360deg)";
              gmail.className = "gmailright";
              linkedin.className = "linkedinright";
              x.offset({ top: 0 , left: w });
              // alert(Math.round(x.offset().left) + " " + Math.round(x.offset().top));
  		      }else{
              centerize(img);
              gmail.className = "gmailleft";
              linkedin.className = "linkedinleft";
            }
        }

        function isCentered(x){
          var jq = $(x);
          var lo = Math.round(jq.offset().left) + Math.round(x.width/2.0) , to = Math.round(jq.offset().top) + Math.round(x.height/2.0);
          var h = Math.round(getDocHeight()/2.0) , w = Math.round(getDocWidth()/2.0);
          if(Math.abs(w - lo) < 10 && Math.abs(h - to) < 10 )
            return true;
          else
            return false;
        }

        function centerize(x){
          // alert("certerizing");
          var jq = $(x);
          var lo = Math.round(jq.offset().left) , to = Math.round(jq.offset().top);
          var h = Math.round(getDocHeight()/2.0) , w = Math.round(getDocWidth()/2.0);
          var th = Math.round(x.height/2.0) , tw = Math.round(x.width/2.0);
          var rdx = w - tw , rdy = h - th;
          var dx = rdx - lo , dy = rdy - to;
          // alert(dx + " " + dy);
          // x.style.webkitTransform = "translate(" + dx + "px," + dy + "px) rotate(0deg)";
          // x.style.MozTransform = "translate(" + dx + "px," + dy + "px) rotate(0deg)";
          // x.style.msTransform = "translate(" + dx + "px," + dy + "px) rotate(0deg)";
          // x.style.oTransform = "translate(" + dx + "px," + dy + "px) rotate(0deg)";
          jq.offset({ top: rdy , left: rdx });
         //      x.style.position = "fixed";
          // x.style.left = "px%";
          // x.style.top = "50%";
    
         //  var width = x.width / 2;
         //  var height = x.height / 2;
    
         // x.style.marginTop = "-" + height + "px";
         // x.style.marginLeft = "-" + width + "px";
        }