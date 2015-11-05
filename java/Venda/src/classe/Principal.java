package classe;

import java.util.ArrayList;
import java.util.Scanner;


public class Principal {
	
	private ArrayList<Cliente> cli;
	
	public Principal(){
		cli=new ArrayList<Cliente>();
	}
	
	public static void main(String[] args){
		
		Principal p = new Principal();
	
		Scanner receber = new Scanner(System.in);
		Scanner recebeString = new Scanner(System.in);
		
		int op=0;
		int reg=0;
		do{
			
			System.out.println("############ MENU ###########");
			System.out.println("Digite uma opcao abaixo:");
			System.out.println("1 - Cadastrar cliente ");
			System.out.println("2 - Listar cliente");
			System.out.println("3 - Deletar cliente");
			System.out.println("4 - Atualizar cliente");
			System.out.println("9 - Sair \n");
			System.out.println("Digite uma Opcao:");
			
			op=receber.nextInt();
			receber.nextLine();
			
			switch(op){
			
			case 1:
				System.out.println("------ Cadastra Cliente -----");
				p.cadastraCliente();
				break;
				
			case 2:
				System.out.println("------ Lista Cliente -----");
				p.listarCliente();
				break;
				
			case 3:
				String cnpj = new String();
				System.out.println("Digite o CNPJ para excluir");
				cnpj = receber.nextLine();
				
				if(p.deletaCliente(cnpj))
					System.out.println("Empresa excluida com sucesso.");
				else
					System.out.println("Não existe esta empresa no cadastro.");
				
				break;
			
			case 4:
				String altera=new String();
				
				
				int op1=0;
				
				System.out.println("------ Alterar Cliente -----");
				System.out.println("Qual registro deseja alterar?");
				
				reg=receber.nextInt();
								
				System.out.println("O que deseja alterar?");
				System.out.println("1 - CNPJ");
				System.out.println("2 - Razao");
				System.out.println("\nDigite uma opcao:");
				
				op1=receber.nextInt();
				
				switch (op1){
				case 1:
					System.out.println("Digite um novo CNPJ:");
					altera=recebeString.nextLine();
					break;
					
				case 2:
					System.out.println("Digite uma a nova Razao");
					altera=recebeString.nextLine();	
					break;	
					
				default:
					System.out.println("Digite uma opcao valida!");
					break;
				}
				
				int resultadoAltera = p.alteraCliente(reg,op1,altera);
				System.out.println("RA:"+resultadoAltera);
				if(resultadoAltera == 1 || resultadoAltera == 2 )
					System.out.println("Dado alterado co sucesso\n");
				else
					System.out.println("Não foi possivel completar essa operação\n");
			break;
		
			
			default:
				System.out.println("Digite uma opcao valida!");
				break;
			}
			
		}while(op!=9);
		receber.close();
	}

	
	public void cadastraCliente(){
		
		String cnpj,razao;
		
		Scanner receber = new Scanner(System.in);
		
		System.out.println("Digite o CNPJ: ");
		cnpj=receber.nextLine();
		
		System.out.println("Digite a razao: ");
		razao=receber.nextLine();
		
		Cliente c1= new Cliente(cnpj,razao);
		
		cli.add(c1);
			
	}
	
	public void listarCliente(){
		for(int c=0;c<=cli.size()-1;c++){	
			System.out.println("\nNum. do registro: "+(c+1));
			System.out.println("CNPJ: "+cli.get(c).getCNPJ());
			System.out.println("Razao: "+cli.get(c).getRazao()+"\n");
		}
	}

	public int alteraCliente(int reg, int op1, String altera){
		
		int tem=0;
		/*
		System.out.println("REG: "+reg);
		System.out.println("OP: "+op1);
		System.out.println("ALT: "+altera);
		*/
		if(op1==1){
			for(int c=0; c<cli.size(); c++){
				//System.out.println("Cd: "+cli.get(c).getCodigo());
				//System.out.println("Ct: "+cli.get(c).getContador());
				if(cli.get(c).getCodigo() == reg){
					cli.get(c).setCNPJ(altera);
					tem=1;
					break;
				}
			}
		}
		
		if(op1==2){	
			for(int c=0; c<cli.size(); c++){
				//System.out.println("Cd: "+cli.get(c).getCodigo());
				//System.out.println("Ct: "+cli.get(c).getContador());	
				if(cli.get(c).getCodigo() == reg){
					cli.get(c).setRazao(altera);
					tem=2;
					break;
				}
			}	
		}
		return tem;
	}
	
	public boolean deletaCliente(String cnpj){
		boolean tem=false;
		for(int c=0;c<cli.size();c++){
			System.out.println("CNPJ: "+cli.get(c).getCNPJ());
			if(cli.get(c).getCNPJ().equals(cnpj)){
				cli.remove(c);
				tem=true;
				break;
			}
		}
		return tem;
	}
}