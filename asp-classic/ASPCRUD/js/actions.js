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
            else{
                return true;
            }           
}

function deslogar(){
            window.location="actions/deslogar.asp";
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
