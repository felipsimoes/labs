package br.com.casadocodigo.livraria.teste;

import br.com.casadocodigo.livraria.produtos.Produto;

public class CarrinhoDeCompras {

	private double total;
	
	//Passando parametro da classe pai
	//polimorfismo de classe
	public void adiciona(Produto produto){
		System.out.println("Adicionando: " + produto);
		//produto.aplicaDescontoDe(0.16);
		total += produto.getValor();
	}
	
	
	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
