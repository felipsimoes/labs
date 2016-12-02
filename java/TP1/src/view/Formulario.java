package view;

import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

import business.FormAbstrato;

public class Formulario extends FormAbstrato {
	
	private JFrame form;
	private JLabel lblNome;
	private JTextField txtNome;
	private JButton btnIncluir;
	private ArrayList<String> refLista;

	public Formulario(ArrayList<String> lista) {
		refLista = lista;
		inicializarComponentes();
	}
	
	protected void inicializarComponentes(){
		declaraForm();

		Container painel = form.getContentPane();

		declaraLabels();
		painel.add(lblNome);

		declarandoTxtFields();
		painel.add(txtNome);

		definirBotoes();
		painel.add(btnIncluir);

		form.setVisible(true);
	}

	private void declarandoTxtFields() {
		txtNome = new JTextField();
		txtNome.setBounds(90, 30, 230, 25);
		txtNome.setFont(new Font("Verdana", Font.PLAIN, 12));
		txtNome.addKeyListener(new KeyListener() {
			@Override
			public void keyTyped(KeyEvent e) {
				String numeros = "0123456789";
				if (numeros.contains(e.getKeyChar() + "")){
					e.consume();
				}
			}

			@Override
			public void keyPressed(KeyEvent e) {
				if (e.getKeyCode() == KeyEvent.VK_ENTER){
					confirmarInclusao();
				}
			}

			@Override
			public void keyReleased(KeyEvent e) {
				btnIncluir.setEnabled(txtNome.getText().length() >= 2);
			}
		});
	}

	protected void declaraLabels() {
		lblNome = new JLabel("Nome:");
		lblNome.setBounds(25, 30, 60, 25);
		lblNome.setForeground(Color.BLUE);
		lblNome.setFont(FONT_ARIAL_BOLD);
	}

	private void declaraForm() {
		form = new JFrame();
		form.setTitle("Trabalho P1 - CRUD em ArrayList");
		form.setBounds(350, 150, 400, 300);
		form.setLayout(null);
		form.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
	}

	private void definirBotoes() {
		btnIncluir = new JButton("1 - Incluir Item");
		btnIncluir.setBounds(100, 150, 200, 25);
		btnIncluir.setEnabled(false);
		btnIncluir.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				confirmarInclusao();
			}
		});
	}

	private void confirmarInclusao(){
		refLista.add(txtNome.getText().toString());
		JOptionPane.showMessageDialog(null,  "Item inclu�do!" ); 
	}
}
