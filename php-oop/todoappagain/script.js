$(document).ready(function(){
	$("#input_field").keypress(function(key){
		var keyvalue = key.which; 
		if(keyvalue === 13){
			if(ValidarItem() === true){
				$("#form").attr('action', 'add.php');
			}
		}
	});
});

function ValidarItem(){
	var texto = $("#input_field").val();
	texto = $.trim(texto);
	if(texto === ""){
		alert("Favor preencher");
		return false;
	}
	else{
		return true;
	}
}
