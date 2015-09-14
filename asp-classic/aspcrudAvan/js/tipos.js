function gerenciarTipos(p) {
	$.get("actions/gerenciarTipos.php?" + p)
		.done(function(data) {
			$("#tipos").append(data);
			$(".chosen-select").chosen();
		});
}
