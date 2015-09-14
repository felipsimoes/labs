function Validar(){
    		var f = document.login;
    		var nome = f.userlogin.value;
    		var password = f.userpsw.value;
    		
    		if(nome == ""){
    			document.getElementById("erro").innerHTML = "Por favor, insira um nome válido.";
	   			return false;
    		}
    		else if(password == ""){
    			document.getElementById("erro").innerHTML = "Por favor, insira uma senha.";
    			return false;
    		}
    		else{
    			return true;
    		}	
}

function ValidarCadastro(){
            var f = document.cadastro;
            var nome = f.username.value;
            var email = f.useremail.value;
            var bday = f.userbday.value;
            var categ = f.usercategory.value;
            var subtipo = f.usersubtype.value;
            var resp = grecaptcha.getResponse();
            var x = f.x.value;
            var preview = $("#image_preview").css('display');
            
            if(nome == ""){
                document.getElementById("erro").innerHTML = "Por favor, insira um nome válido.";
                return false;
            }
            else if(email == ""){
                document.getElementById("erro").innerHTML = "Por favor, insira um email.";
                return false;
            }
            else if(bday == ""){
                document.getElementById("erro").innerHTML = "Por favor, insira uma data de nascimento.";
                return false;
            }
            else if(categ == ""){
                document.getElementById("erro").innerHTML = "Por favor, insira pelo menos uma categoria.";
                return false;
            }
            else if(subtipo == ""){
                document.getElementById("erro").innerHTML = "Por favor, insira pelo menos um subtipo.";
                return false;
            }
            else if(resp == ""){
                document.getElementById("erro").innerHTML = "Por favor, faça o teste de validação.";
                return false;
            }
            else if(preview === 'block' && x <= 0){
                document.getElementById("erro").innerHTML = "Por favor, selecione sua thumbnail.";
                return false;
            }
            else{
                return true;
            }           
}

function deslogar(){
            window.location="actions/deslogar.php";
}

function ValidarNovaCategoria(){
            var f = document.alteracao;
            var nome = f.categoryname.value;
            
            if(nome == ""){
                document.getElementById("erro").innerHTML = "Por favor, insira um nome válido.";
                return false;
            }
            else{
                return true;
            }           
}

$(function() {
    $("#datepicker").datepicker({
    dateFormat: 'dd/mm/yy',
    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    nextText: 'Próximo',
    prevText: 'Anterior'
    });
});
