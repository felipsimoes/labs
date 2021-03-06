package br.com.casadocodigo.livraria.teste;

import java.util.List;

import br.com.casadocodigo.livraria.Autor;
import br.com.casadocodigo.livraria.produtos.Ebook;
import br.com.casadocodigo.livraria.produtos.Livro;
import br.com.casadocodigo.livraria.produtos.LivroFisico;
import br.com.casadocodigo.livraria.produtos.Produto;

public class RegistroDeVendas {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Autor autor = new Autor();
		autor.setEmail("Mauricio Aniche");
		
		LivroFisico fisico = new LivroFisico(autor);
		fisico.setNome("Test-Driven Development");
		fisico.setValor(59.90);
		
		if(fisico.aplicaDescontoDe10Porcento()){
			System.out.println("Valor agora � " + fisico.getValor());
		}
	
		Ebook ebook = new Ebook(autor);
		ebook.setNome("Test-Driven Development");
		ebook.setValor(29.90);
	
		CarrinhoDeCompras carrinho = new CarrinhoDeCompras();
		carrinho.adiciona(fisico);
		carrinho.adiciona(ebook);
		
		System.out.println("Total " + carrinho.getTotal());
		List<Produto> produtos = carrinho.getProdutos();
		
		for(Produto produto: produtos){
			System.out.println(produto);
		}
		
	}

}
