package br.com.casadocodigo.livraria;

public class Autor {
	private String nome;
	private String email;
	private String cpf;
	
	public void mostrarDetalhes(){
		System.out.println("Mostrando detalhes do autor");
		System.out.println("Nome "+nome);
		System.out.println("Email " +email);
		System.out.println("CPF " + cpf);
	}

	@Override
	public String toString(){
		return "Autor: "+nome;
	}
	
	@Override
	public boolean equals(Object obj){
		Autor outro;
		try {
			outro = (Autor) obj;
		} catch (Exception e) {
			return false;
		}
		return this.nome.equals(outro.nome);
	}
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	
	
}
