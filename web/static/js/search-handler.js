(function () {
   window.SearchHandler = (function() {
     return  {
       bindEvents : function(target) { 
         var targetSelector = "[data-id='"+target+"']";
         $(document).keyup(function(e) {
           var code = e.which ? e.which : e.keyCode;
           if( 83 === code) {
             $(targetSelector).focus();
           }
         });
       }
     };
   }());
}());
