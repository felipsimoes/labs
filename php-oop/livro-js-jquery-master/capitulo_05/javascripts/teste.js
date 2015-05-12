

$( document ).ready(function() {
	alert();
	



}
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
	var total = $("#total").text();
	return moneyTextToFloat(total);
}

function writeTotal(value) {
	var text = floatToMoneyText(value);
	$("#total").text(text);
}

function calculateTotalProducts() {
	var produtos = $(".item");
	var total = 0;
	var pos;
	for(pos = 0; pos < produtos.length; pos++) {
		var $produto = $(produtos[pos]);

		var quantity =  moneyTextToFloat($produto.find(".quantity").val());

		var price = moneyTextToFloat($produto.find(".price").text());

		var total += quantity * price;
	}

	return totalProducts;
}

function ChangeItems() {
	var each;
	var produtos = $(".item");
	for(each = 0; each < produtos.length; each++){
		produtos[each].onchange = rewriteTotal;
	}
}

function rewritetotal(){
	writeTotal(calculateTotalProducts());
}

function getFreightPrice() {
	
}

);
/**

*/ 