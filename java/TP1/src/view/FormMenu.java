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

import business.FormAbstrato;
import business.Imovel;

@SuppressWarnings("serial")
public class FormMenu extends FormAbstrato{
	private static final Font FONT_ARIAL_BOLD = new Font("Arial", Font.BOLD, 16);
	private JFrame form;
	private JLabel lblTitulo;
	private JButton btnIncluir;
	private JButton btnListar;
	private JButton btnBuscar;
	private Container painel;
	private ArrayList<Imovel> lista = new ArrayList<>();

	public FormMenu() {
		lista.add(new Imovel("Av.Primeiro Im�vel 001", 150, 2, 1200));
		inicializarComponentes();
	}

	protected void inicializarComponentes(){
		declaraForm();

		painel = form.getContentPane();

		declaraLabels();
		painel.add(lblTitulo);

		definirBotoes();

		form.setVisible(true);
	}

	protected void declaraLabels() {
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

	private void definirBotoes() {
		defBotaoIncluir();
		defBotaoListar();
		defBotaoBuscar();
		
		painel.add(btnIncluir);
		painel.add(btnListar);
		painel.add(btnBuscar);
	}

	private void defBotaoBuscar() {
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

	private void defBotaoListar() {
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

	private void defBotaoIncluir() {
		btnIncluir = new JButton("1 - Incluir Item");
		btnIncluir.setBounds(100, 150, 200, 25);
		btnIncluir.setEnabled(true);
		btnIncluir.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				new Formulario(lista);
			}
		});
	}
}
