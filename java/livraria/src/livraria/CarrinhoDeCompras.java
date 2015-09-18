package livraria;

public class CarrinhoDeCompras {

	private double total;
	
	//Passando parametro da classe pai
	//polimorfismo de classe
	public void adiciona(Livro livro){
		System.out.println("Adicionando " + livro);
		livro.aplicaDescontoDe(0.13);
		total += livro.getValor();
	}
	
	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
