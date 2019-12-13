# css style of busy gif
styleBusy = function(){
  paste0("
    position: fixed; top: 0px; left: 0px; 
    width: 100%; height:100%; 
    background-color: #ffffff; opacity: 0.8; 
    text-align: center;
    z-index: 100;
         ")
}

# check busy state
busyChecker = function(){
  paste0("setInterval(function(){
     if ($('html').attr('class')=='shiny-busy') {
       $('div.busy').show()
     } else {
       $('div.busy').hide()
     }
   },500)")
}