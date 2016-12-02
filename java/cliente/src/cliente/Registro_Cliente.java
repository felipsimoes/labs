package cliente;

public abstract class Registro_Cliente {
	String nome;
	int idade;
	
	public void add(Registro_Cliente a){}
	
	public void remove(Registro_Cliente b){}
	
	public String getNome() {return nome;}
	
	public int getIdade() {return idade;}
	
	public void print(){}
}
