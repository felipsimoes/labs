package classe;

public class Vendas {
	private Cliente cli;
	private Produto prod;
	private String vendedor;
	
	public Vendas(Cliente c,Produto p,String v){
		cli=c;
		prod=p;
		vendedor=v;
	}

	public Cliente getCli() {
		return cli;
	}

	public void setCli(Cliente cli) {
		this.cli = cli;
	}

	public Produto getProd() {
		return prod;
	}

	public void setProd(Produto prod) {
		this.prod = prod;
	}

	public String getVendedor() {
		return vendedor;
	}

	public void setVendedor(String vendedor) {
		this.vendedor = vendedor;
	}
}
