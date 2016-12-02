package cliente;
import java.util.*;

public class Dados_Cliente {
	ArrayList b = new ArrayList();
	String nome;
	int idade;
	
	public Dados_Cliente(String nome, int idade){
		this.nome = nome;
		this.idade = idade;
	}
	public void add(Registro_Cliente c){
		b.add(c);
	}
	public void remove(Registro_Cliente d){
		b.remove(d);
	}
	public String getNome(){
		return nome;
	}
	public int getIdade(){
		return idade;
	}
	public void print(){
		System.out.println("Nome do cliente\t"+getNome()+"\nidade\t"+getIdade());
	}
}
