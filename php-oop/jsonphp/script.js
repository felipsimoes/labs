/** 
Capturar itens do banco de dados
*/

function CarregarItens() {
	// variaveis
	var itens = "", url = "dados.php";

	// Capturar dados usando Método Ajax do jQuery
	$.ajax({

		url: url,
		cache: false,
		dataType: "json",
		beforeSend: function() {
			$("h2").html("Carregando..."); //Carregando
		},
		error: function() {
			$("h2").html("Há algum problema com a fonte de dados");
		},
		success: function(retorno){
			if(retorno[0].erro){
				$("h2").html(retorno[0].erro);
			}
			else {
				//laço para criar linhas da tabela
				for(var i=0;i<retorno.length;i++){
					itens += "<tr>";
					itens += "<td>" + retorno[i].id + "</td>";
					itens += "<td>" + retorno[i].nome + "</td>";
					itens += "<td>" + retorno[i].autor + "</td>";
					itens += "<td>" + TextoEmMoeda(retorno[i].preco) + "</td>";
					itens += "</tr>";
				}
				//Preencher a tabela
				$("#contentTable tbody").html(itens);

				//Limpar status de carregando
				$("h2").html("Carregado!");	
			}
		}
	}); //fecha Ajax
}

function TextoEmMoeda(texto) {
	var moeda; 
	moeda = "R$ " + texto;
	return moeda.substr(0,moeda.length - 3) + "," + moeda.substr(-2);
}