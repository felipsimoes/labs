package br.com.casadocodigo.livraria.teste;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class TestandoPerformance {

	public static void main(String[] args) {
		
		//List<String> colecao = new ArrayList<String>();
		Set<String> colecao = new HashSet<String>(); 
		
		int duracao = 10000;
		
		for(int i=0; i < duracao; i++){
			colecao.add("Item"+i);
		}
		
		long inicio = System.currentTimeMillis();
		
		for (int i = 0; i < duracao; i++) {
			colecao.contains("Item"+i);
		}
		
		long fim = System.currentTimeMillis();
		long tempo = fim - inicio;
		System.out.println("Demorou "+tempo+" milissegundos para executar." );
	}

}
