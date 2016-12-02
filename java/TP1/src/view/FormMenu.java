package view;

import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

public class FormMenu {
	private static final Font FONT_ARIAL_BOLD = new Font("Arial", Font.BOLD, 16);
	private JFrame form;
	private JLabel lblTitulo;
	private JButton btnIncluir;
	private JButton btnListar;
	private JButton btnBuscar;
	private Container painel;
	private ArrayList<String> lista = new ArrayList<>();
	private Formulario formInc;

	public FormMenu() {
		lista.add("TESTE");
		inicializarComponentes();
	}

	private void inicializarComponentes(){
		declaraForm();

		painel = form.getContentPane();

		declaraLabels();
		painel.add(lblTitulo);

		definirBotoes(lista);

		form.setVisible(true);
	}

	private void declaraLabels() {
		lblTitulo = new JLabel("Selecione a op��o desejada:");
		lblTitulo.setBounds(80, 60, 300, 25);
		lblTitulo.setForeground(Color.BLUE);
		lblTitulo.setFont(FONT_ARIAL_BOLD);
	}

	private void declaraForm() {
		form = new JFrame();
		form.setTitle("Trabalho P1 - CRUD em ArrayList");
		form.setBounds(350, 150, 400, 400);
		form.setLayout(null);
		form.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}

	private void definirBotoes(ArrayList<String> lista) {
		defBotaoIncluir(lista);
		defBotaoListar(lista);
		defBotaoBuscar(lista);
		
		painel.add(btnIncluir);
		painel.add(btnListar);
		painel.add(btnBuscar);
	}

	private void defBotaoBuscar(ArrayList<String> lista) {
		btnBuscar = new JButton("3 - Buscar Item");
		btnBuscar.setBounds(100, 210, 200, 25);
		btnBuscar.setEnabled(true);
		btnBuscar.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				new FormBuscar(lista);
			}
		});
	}

	private void defBotaoListar(ArrayList<String> lista) {
		btnListar = new JButton("2 - Listar Itens");
		btnListar.setBounds(100, 180, 200, 25);
		btnListar.setEnabled(true);
		btnListar.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				new FormListaItens(lista);
			}
		});
	}

	private void defBotaoIncluir(ArrayList<String> lista) {
		btnIncluir = new JButton("1 - Incluir Item");
		btnIncluir.setBounds(100, 150, 200, 25);
		btnIncluir.setEnabled(true);
		btnIncluir.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				formIncluir();
			}
		});
	}

	protected void formIncluir() {
//		if(formInc == null){
			formInc = new Formulario(lista);
//		}
	}
}
