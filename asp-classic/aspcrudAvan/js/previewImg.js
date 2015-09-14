$(document).ready(function (e) {
	$("#file").on('submit',(function(e) {
	e.preventDefault();
	$("#message").empty();
	$('#loading').show();
	$.ajax({
		url: "cadastro.asp", // Url to which the request is send
		type: "POST",             // Type of request to be send, called as method
		data: new FormData(this), // Data sent to server, a set of key/value pairs (i.e. form fields and values)
		contentType: false,       // The content type used when sending data to the server.
		cache: false,             // To unable request pages to be cached
		processData:false,        // To send DOMDocument or non processed data file it is set to false
		success: function(data)   // A function to be called if request succeeds
			{			
				$('#loading').hide();
				$("#message").html(data);
			}
		});
	}));

// Function to preview image after validation
$(function() {
	$("#file").change(function() {
		$("#message").empty(); // To remove the previous error message
		var file = this.files[0];
		var imagefile = file.type;
		var match= ["image/jpeg","image/png","image/jpg"];
		if(!((imagefile==match[0]) || (imagefile==match[1]) || (imagefile==match[2])))
		{
		$('#previewing').attr('src','files/noimage.png');
		$("#message").html("<p id='error'>Please Select A valid Image File</p>"+"<h4>Note</h4>"+"<span id='error_message'>Only jpeg, jpg and png Images type allowed</span>");
		return false;
		}
		else
		{
			var reader = new FileReader();
			reader.onload = imageIsLoaded;
			reader.readAsDataURL(this.files[0]);
		}
		});
});
function imageIsLoaded(e) {
	$("#crop_area").css("display","block");
	$("#file").css("color","green");
	$('#image_preview').css("display", "block");
	$('#button-redimensionar').css("display", "block");
	$("#crop_form").css("display", "block");
	$("#previewthumb").css("display", "block");
	$('#previewing').attr('src', e.target.result);
	$('#previewing').attr('width', '350px');
	$("#testimg").attr("value",e.target.result);
	$("#previewthumb").attr('src', e.target.result);
	var $pcnt = $('#preview-pane .preview-container'),
	xsize = $pcnt.width(),
    ysize = $pcnt.height();
    var img = document.getElementById('previewing'); 
	var largura = img.naturalWidth;
	var altura = img.naturalHeight;	
	$('#previewing').Jcrop({
		trueSize: [largura,altura],
		onSelect: exibePreview,
		onChange: exibePreview,
		aspectRatio: xsize / ysize
	},function(){
      // Use the API to get the real image size
      var bounds = this.getBounds();
      boundx = bounds[0];
      boundy = bounds[1];
      // Store the API in the jcrop_api variable
      jcrop_api = this;

  });
  	$(".jcrop-holder img").attr("src",e.target.result); 
	
}

//redimensionar imagem
$(function() {
	$("#button-redimensionar").click(function checkCoords() {
      if (parseInt($('#w').val())) {
        	jcrop_api.destroy();
        	$("#crop_area").css("display","none");
        	return false;       		
        } 
        alert('Por favor selecione a porção da imagem antes de redimensionar.');
        return false;
      });});  

      function exibePreview(c)
    {
        var rx =   250 / parseInt(c.w) ;
        var ry =   170 / parseInt(c.h) ;
 
        // atualiza CSS do preview para refletir o tamanho da imagem enviada 
        // e o posicionamento do crop
        $('#previewthumb').css({
            width: Math.round(rx * boundx) + 'px',
            height: Math.round(ry * boundy) + 'px',
            marginLeft: '-' + Math.round(rx * c.x) + 'px',
            marginTop: '-' + Math.round(ry * c.y) + 'px'
        });
        
        // campos hidden que armazenam os valores
        $('#x').val(Math.round(c.x));
        $('#y').val(Math.round(c.y));
        $('#w').val(Math.round(c.w));
        $('#h').val(Math.round(c.h));
    };

});

