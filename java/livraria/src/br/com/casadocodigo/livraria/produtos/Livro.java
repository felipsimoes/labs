package br.com.casadocodigo.livraria.produtos;

import br.com.casadocodigo.livraria.Autor;
import br.com.casadocodigo.livraria.exception.AutorNuloException;

public abstract class Livro implements Produto {
	private String nome;
	private String descricao;
	private double valor;
	private String isbn;
	private Autor autor;
	private boolean impresso;
	
	//A assinatura que recebe Autor
	//utiliza as defini��es de inicializa��o
	//do construtor sem par�metros
	public Livro(Autor autor){
		
		if(autor == null){
			throw new AutorNuloException("O Autor do Livro n�o pode ser nulo");
		}
		this.isbn = "000-00-00000-00-0";
		this.autor = autor;
	}
	
	public Livro(){
		this.isbn = "000-00-00000-00-0";
		this.impresso = true;
	}
	
	public void mostrarDetalhes(){
		System.out.println("Mostrando detalhes do livro");
		System.out.println("Nome "+nome);
		System.out.println("Descri��o "+descricao);
		System.out.println("Valor" +valor);
		System.out.println("ISBN" + isbn);
		
		if(this.temAutor()){
			autor.mostrarDetalhes();
		}
		
		System.out.println("--");
	}
	
	@Override
	public String toString(){
		System.out.println("Nome: "+nome);
		System.out.println("Descri��o: "+descricao);
		System.out.println("Valor: "+valor);
		System.out.println("ISBN: "+isbn);
		
		if(this.temAutor()){
			autor.toString();
		}
		
		System.out.println("--");
		return "";
		
	}
	
	public abstract boolean aplicaDescontoDe(double porcentagem);
		
	public boolean temAutor(){
		return this.autor != null;
	}
		
	public double getValor(){
		return this.valor;
	}
	
	public void setValor(double valor){
		this.valor = valor;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public Autor getAutor() {
		return autor;
	}

	public void setAutor(Autor autor) {
		this.autor = autor;
	}
	
}	

