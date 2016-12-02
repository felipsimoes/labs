package br.com.casadocodigo.testes;
import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;

import br.com.casadocodigo.classes.*;

public class Capitulo2 {

	public static void main(String[] args) {
		Usuario user1 = new Usuario("Paulo Silveira", 150);
		Usuario user2 = new Usuario("Rodrigo Turini", 120);
		Usuario user3 = new Usuario("Guilherme Silveira", 190);

		List<Usuario> usuarios = Arrays.asList(user1,user2,user3);
		
		for(Usuario u : usuarios){
			System.out.println(u.getNome());
		}
		
		System.out.println("_____________\n");
		System.out.println("Mostrador:\n");
		
		Mostrador mostrador = new Mostrador();
		usuarios.forEach(mostrador);
		
		System.out.println("_____________\n");
		System.out.println("Mostrador - classe anônima:\n");
		
		Consumer<Usuario> mostrador2 = new Consumer<Usuario>(){
			public void accept(Usuario u){
				System.out.println(u.getNome());
			}
		};
		
		usuarios.forEach(mostrador2);
		
		//Classe Anônima mais enxuta
		System.out.println("_____________\n");
		System.out.println("Mostrador - classe anônima enxuta:\n");
		
		usuarios.forEach(new Consumer<Usuario>(){
			public void accept(Usuario u){
				System.out.println(u.getNome());
			}
		});
		
		//Classe Anônima mais enxuta AINDA, com lambda
		System.out.println("_____________\n");
		System.out.println("Mostrador - classe anônima enxuta Lambda:\n");
		
		Consumer<Usuario> mostrador3 = 
				(Usuario u) -> { System.out.println(u.getNome()); };
	}

}
