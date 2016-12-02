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
import business.Imovel;

@SuppressWarnings("serial")
public class FormBuscar extends FormAbstrato{

	private JFrame form;
	private JLabel lblNome;
	private JTextField txtNome;
	private JButton btnAlterar;
	private ArrayList<Imovel> refLista;
	private JButton btnExcluir;
	private Container painel;
	
	public FormBuscar(ArrayList<Imovel> lista) {
		refLista = lista;
		inicializarComponentes();
	}

	protected void inicializarComponentes() {
		declaraForm();

		painel = form.getContentPane();

		declaraLabels();
		painel.add(lblNome);

		declarandoTxtFields();
		painel.add(txtNome);

		definirBotoes();

		form.setVisible(true);
	}

	private void definirBotoes() {
		btnAlterar = new JButton("Alterar Item");
		btnAlterar.setBounds(100, 150, 200, 25);
		btnAlterar.setEnabled(false);
		btnAlterar.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				try {
					String t = txtNome.getText();
					int id = Integer.parseInt(t);
					if( refLista.get(id) != null ) {
						new Formulario(refLista, id);
					}else{
						mensagemIdNaoEncontrado();
					}
				} catch (Exception exception) {
					System.out.println(exception.getMessage());
					mensagemProblemaId();
				}
			}
		});
		
		btnExcluir = new JButton("Excluir Item");
		btnExcluir.setBounds(100, 180, 200, 25);
		btnExcluir.setEnabled(false);
		btnExcluir.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				try {
					String t = txtNome.getText();
					int id = Integer.parseInt(t);
					if( refLista.remove(id) != null ) {
						JOptionPane.showMessageDialog(null,  "Item exclu�do!" ); 	
					}else{
						System.out.println("aqui");
						mensagemIdNaoEncontrado();
					}
					
				} catch (Exception exc) {
					System.out.println(exc.getMessage());
					mensagemProblemaId();
				}
			}
		});
		
		
		painel.add(btnAlterar);
		painel.add(btnExcluir);
	}
	
	private void mensagemIdNaoEncontrado() {
		JOptionPane.showMessageDialog(null,  "Item com esse id n�o pode ser encontrado" );
	}

	private void mensagemProblemaId() {
		JOptionPane.showMessageDialog(null,  "Houve um problema na busca desse id" );
	}
	
	private void declarandoTxtFields() {
		txtNome = new JTextField();
		txtNome.setBounds(130, 30, 50, 25);
		txtNome.setFont(new Font("Verdana", Font.PLAIN, 12));
		txtNome.addKeyListener(new KeyListener() {
			@Override
			public void keyTyped(KeyEvent e) {
				String numeros = "0123456789";
				if (!numeros.contains(e.getKeyChar() + "")){
					e.consume();
				}
			}

			@Override
			public void keyPressed(KeyEvent e) {
				if (e.getKeyCode() == KeyEvent.VK_ENTER){
//					confirmarInclusao();
				}
			}

			@Override
			public void keyReleased(KeyEvent e) {
				btnAlterar.setEnabled(txtNome.getText().length() >= 1);
				btnExcluir.setEnabled(txtNome.getText().length() >= 1);
			}
		});
	}

	protected void declaraLabels() {
		lblNome = new JLabel("C�digo:");
		lblNome.setBounds(50, 30, 80, 25);
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
}
