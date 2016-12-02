package cliente;

public class Cliente extends Registro_Cliente {
	String nome;
	int idade;
	
	public Cliente(String nome, int idade){
		this.nome = nome;
		this.idade = idade;
	}
	public String getNome(){
		return nome;
	}
	public int getIdade(){
		return idade;
	}
	public void print(){
		System.out.println("Nome do clinte\t"+getNome()+"\nidade\t"+getIdade());
	}
}
