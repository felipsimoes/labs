package br.com.casadocodigo.livraria.teste;

import br.com.casadocodigo.livraria.produtos.Produto;

public class CarrinhoDeCompras {

	private double total;
	private Produto[] produtos = new Produto[10];
	private int contador = 0;
	
	//Passando parametro da classe pai
	//polimorfismo de classe
	public void adiciona(Produto produto){
		System.out.println("Adicionando: " + produto);
		this.produtos[contador] = produto;
		contador++;
		this.total += produto.getValor();
	}
	
	public void getCadaProduto(){	
		for(Produto produto: produtos){
			if(produto != null){
				System.out.println(produto.getValor());
			}
		}
		System.out.println("Fui executado!");
	}
	
	public Produto[] getProdutos(){
		return produtos;
	}
	
	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
