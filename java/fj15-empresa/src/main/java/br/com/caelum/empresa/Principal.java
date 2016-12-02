package br.com.caelum.empresa;

import java.util.Calendar;
import java.util.GregorianCalendar;

import br.com.caelum.empresa.modelo.Funcionario;

public class Principal {
	public static void main(String[] args) {
		Calendar dataNascimento = new GregorianCalendar(1989, 4, 22);
		Funcionario funcionario = new Funcionario("Felipe", 0, dataNascimento);
		System.out.println(funcionario);
		Funcionario funcionario2 = new Funcionario("F", 1, dataNascimento);
	}
}
