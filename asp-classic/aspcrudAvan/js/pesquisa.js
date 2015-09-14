function pesquisaAjax(p,c) {
	$.get("actions/pesquisa.asp?" + p + "&ctg=" + c)
		.done(function(data) {
			$("#resultado").html(data);
		});
}

$(document).ready(function() {
	// Sender das pesquisas
	$.ajaxSetup({
		cache: false
	});
	$("#pesquisaForm").on("submit", function(e) {
		e.preventDefault();
		var cat = 'nm_nome';
		pesquisaAjax($(this).serialize(),cat);
	});

	$("#mainPesquisa").on("input", function() {
		$("#pesquisaForm").submit();
	});

});