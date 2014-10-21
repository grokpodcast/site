
/*
2014 Grok Podcast
Author: HE:labs
*/


// Console

if(typeof(console) == 'undefined') console = { log : function(){} };
if(typeof(console.log) != 'function') console.log = function(){};


// Functions

var App = {

    StartApp: function() {
      try {
        this.InterfaceActions();
      } catch (e) {
        alert('Existem erros no script.');
        console.log('Error: ' + e);
      }
    },

    InterfaceActions: function() {

      /* Menu: Mobile */

      $("#nav-trigger").click(function() {
        $("#topbar ul").toggle();
      });

    }

} // Var Site

jQuery(function(){
	App.StartApp();
});
