function moneyTextToFloat(text) {
	var cleanText = text.replace("R$ ", "").replace(",", ".");
	return parseFloat(cleanText);
}

function floatToMoneyText(value) {
	var text = (value < 1 ? "0" : "") + Math.floor(value * 100);
	text = "R$ " + text;
	return text.substr(0, text.length - 2) + "," + text.substr(-2);
}

function readTotal() {
	var total = document.getElementById("total");
	return moneyTextToFloat(total.innerHTML);
}

function writeTotal(value) {
	var total = document.getElementById("total");
	total.innerHTML = floatToMoneyText(value);
}

function calculateTotalProducts() {
	var produtos = document.getElementsByClassName("produto");

	var totalProdutos = 0;

	for(var pos = 0; pos < produtos.length; pos++) {
		var priceElements = produtos[pos].getElementsByClassName("price");
		var priceText = priceElements[0].innerHTML;
		var price = moneyTextToFloat(priceText);

		var qtyElements = produtos[pos].getElementsByClassName("quantity");
		var qtyText = qtyElements[0].value;
		var quantity = moneyTextToFloat(qtyText);

		var subtotal = quantity * price;

		totalProdutos += subtotal;

	}

	return totalProdutos;
}
//A funcao reescreve o total de valor da compra
//que por sua vez é reescrito chamando-se a funcao
//calculateTotalProducts que gera o valor numerico e
//precisa ser convertido em texto
function onQuantityChange() {
	writeTotal(calculateTotalProducts());
}
//A funcao pega todos os elementos de classe Quantity
//os elementos sao colocado em um array que é mapeado
//Toda mudança feita em algum destes elementos (método onchange)
//deve chamar a função on QuantityChange
function onDocumentLoad() {
	var textEdits = document.getElementsByClassName("quantity");

	for(var i = 0; i < textEdits.length; i++) {
		textEdits[i].onchange = onQuantityChange;
	}
}
//Quando a pagina é carregada/alterada chama-se a funcao onDocumentLoad
window.onload = onDocumentLoad;