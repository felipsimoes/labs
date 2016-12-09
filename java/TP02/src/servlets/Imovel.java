package servlets;

public class Imovel {
	private String endereco;
	private int metrosQuadrados;
	private int numQuartos;
	private int valorLocacao;
	private int cd;

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}

	public int getMetrosQuadrados() {
		return metrosQuadrados;
	}

	public void setMetrosQuadrados(int metrosQuadrados) {
		this.metrosQuadrados = metrosQuadrados;
	}

	public int getNumQuartos() {
		return numQuartos;
	}

	public void setNumQuartos(int numQuartos) {
		this.numQuartos = numQuartos;
	}

	public int getValorLocacao() {
		return valorLocacao;
	}

	public void setValorLocacao(int valorLocacao) {
		this.valorLocacao = valorLocacao;
	}
	
	public int getCd() {
		return cd;
	}

	public void setCd(int cd) {
		this.cd = cd;
	}

	public Imovel(String end, int metros, int quartos, int valor) {
		this.endereco = end;
		this.metrosQuadrados = metros;
		this.numQuartos = quartos;
		this.valorLocacao = valor;
	}
	
	public Imovel(){ 	}
}

