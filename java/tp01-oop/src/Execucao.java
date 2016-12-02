import java.util.ArrayList;
import java.util.Scanner;

public class Execucao {
	public static ArrayList<Pessoa> lista = new ArrayList();
	public static Scanner s;
	
	public static void menu() {
		System.out.println("1 - Inserir nova Pessoa");
		System.out.println("2 - Listar Pessoas");
		System.out.println("3 - Atualizar Pessoa");
		System.out.println("4 - Deletar Pessoa");
		System.out.println("5 - Encerrar programa");
	}
	
	public static void op1(){
		System.out.println("Digite 1 para nova Pessoa");
		System.out.println("Digite 2 para novo Professor");
		System.out.println("Digite 3 para novo Coordenador");
		System.out.println("Digite 4 para novo Aluno");
	}
	
	public static void op2() {
		for(Pessoa x: lista){
			// caso a atual seja uma instância de classe específica de Pessoa
			if(x.getClass().equals(Pessoa.class)){
				System.out.println("Nome: "+ x.getNome());
				System.out.println("Pessoa que não trabalha não tem salário");
			}
			else if(x.getClass().equals(Professor.class)){
				double y = ((Professor) x).getSalario();
				System.out.println("Nome: "+ x.getNome());
				System.out.println("Salário deste professor é de R$" + y);
			}
			else if(x.getClass().equals(Coordenador.class)) {
				double y = ((Coordenador) x).getSalario();
				int q = ((Coordenador) x).getTot_alunos();
				System.out.println("Nome: "+ x.getNome());
				System.out.println("Salário deste Coordenador é de R$" + y);
				System.out.println("Quantidade de alunos deste coordenador é " + q);
			}
			else if(x.getClass().equals(Aluno.class)){
				System.out.println("Nome: "+ x.getNome());
				System.out.println("Aluno que não trabalha ou estagia não tem salário");
			}
		}
	}
	
	public static void res1(int x){
		//Scanner sc = new Scanner(System.in);
		switch(x){
		case 1:
			System.out.println("Digite o nome:");
			String n;
			n = s.nextLine();
			lista.add(new Pessoa(n));
			n = null;
			System.out.println("Pessoa adicionada.");
			break;
			
		case 2:
			String n1;
			double sh1;
			int th1;
			System.out.println("Digite o nome:");
			n1 = s.nextLine();
			System.out.println("Digite o salário hora:");
			sh1 = s.nextDouble();
			s.nextLine();
			System.out.println("Digite o total de horas:");
			th1 = s.nextInt();
			s.nextLine();
			lista.add(new Professor(n1,sh1,th1));
			n1 = null;	
			System.out.println("Professor(a) adicionado(a).");
			break;
			
		case 3:
			String n2;
			double sh2;
			int th2;
			int ta;
			System.out.println("Digite o nome:");
			n2 = s.nextLine();
			s.nextLine();
			System.out.println("Digite o salário hora:");
			sh2 = s.nextDouble();
			s.nextLine();
			System.out.println("Digite o total de horas:");
			th2 = s.nextInt();
			s.nextLine();
			System.out.println("Digite o total de alunos:");
			ta = s.nextInt();
			s.nextLine();
			lista.add(new Coordenador(n2,sh2,th2,ta));
			n2 = null;
			System.out.println("Coordenador(a) adicionado(a).");
			break;
			
		case 4:
			System.out.println("Digite o nome:");
			String n4;
			n4 = s.nextLine();
			lista.add(new Aluno(n4));
			n = null;
			System.out.println("Aluno(a) adicionado(a).");
			break;
		}
	}
	
	public static void op4(){
		int a = 1;
		for(Pessoa x:lista){
			System.out.println(a + " - Nome: "+ x.getNome());
			a++;
		}
		System.out.println("Digite o numero da pessoa que deseja remover:");
		a = s.nextInt();
		lista.remove(a-1);
		System.out.println("Pessoa removida");
	}
	
	public static void op3(){
		int a = 1;
		for(Pessoa x:lista){
			System.out.println(a + " - Nome: "+ x.getNome());
			a++;
		}
		System.out.println("Digite o numero da pessoa cujos dados deseja atualizar:");
		a = s.nextInt();
		res3(a-1);
		System.out.println("Dados atualizados");
	}
	public static void dadosBasicos(){
		System.out.println("1 - Nome");
		System.out.println("2 - Email");
		System.out.println("3 - Endereco");
	}
	public static void atualizarDados(int i){
		switch(i){
		case 1:
			dadosBasicos();
			break;
		case 2:
			dadosBasicos();
			System.out.println("4 - Salario hora");
			System.out.println("5 - Total de horas");
			break;
		case 3:
			dadosBasicos();
			System.out.println("4 - Salario hora");
			System.out.println("5 - Total de horas");
			System.out.println("6 - Total de alunos");
			break;
		}
		System.out.println("7 - Para sair");
	}
	
	public static void res3(int i){
		Pessoa x = lista.get(i);
		int opc = 0;
		while(opc != 7){
			if((x.getClass().equals(Pessoa.class)) || (x.getClass().equals(Aluno.class))){
				atualizarDados(1);
			}
			else if(x.getClass().equals(Professor.class)){
				atualizarDados(2);
			}
			else if(x.getClass().equals(Coordenador.class)) {
				x = ((Coordenador) x);
				atualizarDados(3);
			}
			opc = s.nextInt();
			s.nextLine();
			switch(opc){
			case 1:
				System.out.println("Digite o nome:");
				x.setNome(s.nextLine());
				break;
			case 2:
				System.out.println("Digite o email:");
				x.setEmail(s.nextLine());
				break;
			case 3:
				System.out.println("Digite o endereco:");
				x.setEndereco(s.nextLine());
				break;
			case 4:
				if((x.getClass().equals(Coordenador.class))){
					System.out.println("Digite o salario hora:");
					((Coordenador) x).setSal_hora(s.nextDouble());
				}else if(x.getClass().equals(Professor.class)) {
					System.out.println("Digite o salario hora:");
					((Professor) x).setSal_hora(s.nextDouble());
				}
				else{
					System.out.println("Esta classe nao implementa tal metodo.");
				}
				break;
			case 5:
				if((x.getClass().equals(Coordenador.class))){
					System.out.println("Digite o total de horas:");
					((Coordenador) x).setTot_horas(s.nextInt());
				}else if(x.getClass().equals(Professor.class)) {
					System.out.println("Digite o total de horas:");
					((Professor) x).setTot_horas(s.nextInt());
				}
				else{
					System.out.println("Esta classe nao implementa tal metodo.");
				}
				break;
			case 6:
				if((x.getClass().equals(Coordenador.class))){
					System.out.println("Digite o total de alunos:");
					((Coordenador) x).setTot_alunos(s.nextInt());
				}
				else
					System.out.println("Esta classe nao implementa tal metodo.");
				break;
			}
		}
		

	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Integer op = 0;
		s = new Scanner(System.in);
		while(op != 5){
			menu();
			System.out.println("Digite a opcao desejada:");
			if(s.hasNext()){
				op = s.nextInt();
				s.nextLine();
			}
			else{
				op = Integer.parseInt(s.nextLine());
			}
			switch(op){
				case 1:
					op1();
					op = s.nextInt();
					s.nextLine();
					res1(op);
					op = 0;
					break;
					
				case 2:
					op2();
					break;
				
				case 3:
					op3();
					break;
					
				case 4:
					op4();
					op = 0;
					break;
									
			}
		}
		System.out.println("Fim.");
		s.close();
		
	}

}
