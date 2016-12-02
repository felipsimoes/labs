package cliente;

public class Manipula_Cliente {
	public static void main(String[] args) {
		Registro_Cliente cliente1 = new Cliente("José Guevara",36);
		Registro_Cliente cliente2 = new Cliente("Ana Carolina",32);
		Acesso_Cliente f = new Acesso_Cliente(cliente1);
		Acesso_Cliente g = new Acesso_Cliente(cliente2);
		f.printCliente();
		g.printCliente();
		
		
	}
}
