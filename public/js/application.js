$(document).ready(function(){
 // this ID here refers to the form where the usesr types in a URL, you may have a different name for the ID. Edit the code accordingly.
 console.log("jquery ready");
 $('#url-form').submit(function(event){
   event.preventDefault();        
   $.ajax({
     url: '/submit-post', //this refers to the route post '/urls'
     method: 'POST',
     data: $(this).serialize(),
     dataType: 'json',
     success: function(data){
     // write some code here to display the shortened URL
     console.log("success");
     let base_url = window.location.origin;
     $('tbody').prepend('\
       <tr>\
       <td> ' + data.id + '</td>\
       <td> <a href='+"'/"+data.short_url+"'>"+base_url+'/'+data.short_url+'</a></td>\
       <td> ' + data.long_url+ '</td>\
       <td> ' + data.click_count + '</td>\
       </tr>')
   },
   error: function(response) {
     $('#form-bootstrap-overrides').val(response.responseJSON.error_message)
   }
   }); // end of function .ajax
 }); // end of function .submit
}); // end of function document.ready