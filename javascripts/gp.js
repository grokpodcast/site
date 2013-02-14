
/*
2013 Hora Extra
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
            this.FormActions();
        } catch (e) {
            alert('Existem erros no script.');
            console.log('Error: ' + e);
        }
    },

    InterfaceActions: function() {
		
		

    }, // InterfaceActions

    FormActions: function() {

		// Focus
		$('input[type="text"], input[type="password"], textarea').focus(function() {
			$(this).css("box-shadow", "#ccc 0 0 15px");
		});
		$('input[type="text"], input[type="password"], textarea').blur(function() {
			$(this).css("box-shadow", "none");
		});
		$('input[type="text"], input[type="password"], textarea').focus(function() {
			var li = $(this).parent("li")
			li.data('background', li.css('background-color'));
			li.css("background-color", "#e1e1e1");
		});
		$('input[type="text"], input[type="password"], textarea').blur(function() {
			var li = $(this).parent("li");
			li.css("background-color", li.data('background'));
		});

    } // FormActions

} // Var Site

jQuery(function(){
	App.StartApp();
});