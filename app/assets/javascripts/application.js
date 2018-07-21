// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require selectize
//= require selectize2
//= require index
//= require jquery.dataTables
//= require dataTables.bootstrap4
//= require date-filter
//= require cocoon
//= require toastr
//= require custom-file-input
//= require_tree .
$(function() {
    	$('img').on('click', function() {
			$('.enlargeImageModalSource').attr('src', $(this).attr('src'));
			$('#enlargeImageModal').modal('show');
		});
});



$(document).ready(function() {
$("html").addClass('js');


$( ".input-file-trigger" ).keydown(function(event) {  
    if ( event.keyCode == 13 || event.keyCode == 32 ) {  
        $( ".input-file" ).focus();  
    }  
});
$( ".input-file-trigger" ).click(function() {
   $( ".input-file" ).focus();
}); 
   $('.alert').delay(2000).fadeOut();
   $('.form-select select').addClass('form-control');
   $('.form-select select').addClass('form-control-md');
   $('.form-select select').addClass('mb-3');
});
$(document).click(function() {
$("#product_image").change(function() {  
var values = $(".input-file").val();
var filename = values.replace(/^.*\\/, "");
    $(".file-return").html(filename); 
});
}); 
        /* Custom filtering function which will search data in column four between two values */
        
// $('input[type="checkbox"]').checked(function(){
// var abc = $(this).next('label').html();
// $('.frame-show').html(abc);
// });
$(document).ready(function(){
    $( "#datepicker" ).datepicker({
    monthNames:[ "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" ],
     dateFormat: "yy-mm-dd",
     dayNamesMin: ["Do", "Se", "Te", "Qua", "Qui", "Se", "Sá"]
    });
    $('#datepicker').on('focus', function(e) {
   e.preventDefault();
   $(this).attr("autocomplete", "off");  
});
$('#datepicker2').on('focus', function(e) {
   e.preventDefault();
   $(this).attr("autocomplete", "off");  
});
     $( "#datepicker2" ).datepicker({
    monthNames:[ "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" ],
     dateFormat: "yy-mm-dd",
     dayNamesMin: ["Do", "Se", "Te", "Qua", "Qui", "Se", "Sá"]
    });



// $('#frameModal').modal({backdrop: 'static', keyboard: false})
// Clock and Date
    function GetClock() {
        var tday=new Array("Domingo","Segunda","Terça","Quarta","Quinta","Sexta","Sábado");
        var tmonth=new Array("Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez");
        var d=new Date();
        var nday=d.getDay(),nmonth=d.getMonth(),ndate=d.getDate();
        var nhour=d.getHours(),nmin=d.getMinutes();
        if(nmin<=9) {
            nmin="0"+nmin;
        }

        //document.getElementById('clockbox').innerHTML=""+tday[nday]+", "+tmonth[nmonth]+" "+ndate+" "+nhour+":"+nmin+"";
        $('#clockbox').text(""+tday[nday]+", "+tmonth[nmonth]+" "+ndate+" "+nhour+":"+nmin+"");
    }

     GetClock();
     setInterval(GetClock,1000);


$('select[name="order[client_id]"]').addClass('select-client');
$('select[name="order[frame]"]').addClass('select-frame');
$('select[name="order[passe_partout][]"]').addClass('select-passe');
$('select[name="order[accessory][]"]').addClass('select-accessory');
$('.select-client').selectize({
	maxItems: 1
});
$('.select-frame').selectize({
	maxItems: 1
});
$('.select-passe').selectize({
	maxItems: 4
});
$('.select-accessory').selectize({
	maxItems: 4
});
$('.select-client').change(function(){
    var str = "";
    $( ".select-client option:selected" ).each(function() {
      str += $( this ).text() + " ";
    });
    $( ".text-client" ).text( str );
  })
  .trigger( "change" );

$('.select-frame').change(function(){
 var str = "";
    $( ".select-frame option:selected" ).each(function() {
      str += $( this ).text() + " ";
    });
    $( ".text-frame" ).text( str );
    
  })
  .trigger( "change" );
  
  
$('.select-passe').change(function(){
 var str = "";
    $( ".select-passe option:selected" ).each(function() {
      str += $( this ).text() + " ";
    });
    $( ".text-passe" ).text( str );
  })
  .trigger( "change" );

$('.select-accessory').change(function(){
 var str = "";
    $( ".select-accessory option:selected" ).each(function() {
      str += $( this ).text() + " ";
    });
    $( ".text-accessory" ).text( str );
  })
  .trigger( "change" );
  
   $('.table-index table').DataTable({
            pageLength: 10,
            responsive: true,
            
        });
    
});


function addclient() {
    var x = document.getElementById("clientselect");
    x.style.display = "none"
    var y = document.getElementById("addclient");
    y.style.display = "none"
}

function removeclient() {
    var x = document.getElementById("clientselect");
    x.style.display = "block"
    var y = document.getElementById("addclient");
    y.style.display = "block"
}