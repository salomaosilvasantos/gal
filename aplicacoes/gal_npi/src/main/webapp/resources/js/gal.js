$.fn.serializeObject = function()
{
   var o = {};
   var a = this.serializeArray();
   $.each(a, function() {
       if (o[this.name]) {
           if (!o[this.name].push) {
               o[this.name] = [o[this.name]];
           }
           o[this.name].push(this.value || '');
       } else {
           o[this.name] = this.value || '';
       }
   });
   return o;
};

$( document ).ready(function() {
	
	$('#add-curso-button').click(function() {
	    var $form = $('#add-curso-form');
	    var data = JSON.stringify($form.serializeObject());
	    $.ajax({
	        url: $form.attr("action"),
	        data: data,
	        contentType : "application/json; charset=utf-8",
	        dataType : "json",
	        type: "POST",
	        success: function(data) {
	            alert(data);
	        },
	        error: function(data) {
	            alert('error: ' + data);
	        }
	    });
	});
	
});