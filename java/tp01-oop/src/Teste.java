import java.util.ArrayList;

public class Teste {

	public static void main(String[] args) {
		ArrayList<Pessoa> lista = new ArrayList();
		
		//São feitas uma instância de cada classe
		Pessoa p1 = new Pessoa("Um");
		Professor p2 = new Professor("Dois", 20.0, 40);
		Coordenador p3 = new Coordenador("Tres", 20.0, 40, 800);
		Aluno p4 = new Aluno("Quatro");
		
		lista.add(p1);
		lista.add(p2);
		lista.add(p3);
		lista.add(p4);
		
		// Para cada Pessoa (classe da qual todas herdam)
		for(Pessoa x: lista){
			// caso a atual seja uma instância de classe específica de Pessoa
			// if(x instanceof Pessoa)
			if(x.getClass().equals(Pessoa.class)){
				System.out.println("Pessoa que não trabalha não tem salário");
			}
			else if(x.getClass().equals(Professor.class)){
				double y = ((Professor) x).getSalario();
				System.out.println("Salário deste professor é de R$" + y);
			}
			else if(x.getClass().equals(Coordenador.class)) {
				double y = ((Coordenador) x).getSalario();
				System.out.println("Salário deste Coordenador é de R$" + y);
			}
		}
		//lista.forEach(System.out::println);
		
	}

}
