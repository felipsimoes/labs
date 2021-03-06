package br.com.casadocodigo.livraria.teste;

import java.util.ArrayList;
import java.util.List;

import br.com.casadocodigo.livraria.produtos.Produto;

public class CarrinhoDeCompras {

	private double total;
	private List<Produto> produtos;
	
	public CarrinhoDeCompras(){
		this.produtos = new ArrayList<>();
	}
	//Passando parametro da classe pai
	//polimorfismo de classe
	public void adiciona(Produto produto){
		System.out.println("Adicionando: " + produto);
		this.produtos.add(produto);
		this.total += produto.getValor();
	}
	
	public void remove(int posicao){
		this.produtos.remove(posicao);
	}
	
	public void getCadaProduto(){	
		for(Produto produto: produtos){
			if(produto != null){
				System.out.println(produto.getValor());
			}
		}
		System.out.println("Fui executado!");
	}
	
	public List<Produto> getProdutos(){
		return produtos;
	}
	
	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
