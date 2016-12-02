package cliente;

public class Acesso_Cliente {
	Registro_Cliente e;
	public Acesso_Cliente(Registro_Cliente e){
		this.e = e;
	}
	public void printCliente(){
		e.print();
	}
}
