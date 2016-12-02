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
public class Formulario extends FormAbstrato {
	
	private JFrame form;
	private JLabel lblEndereco;
	private JTextField txtEndereco;
	private Container painel;
	private JButton btnIncluir;
	private ArrayList<Imovel> refLista;
	private boolean alterar = false;
	private int id;
	private JLabel lblArea;
	private JLabel lblQuartos;
	private JLabel lblValor;
	private JTextField txtArea;
	private JTextField txtQuartos;
	private JTextField txtValor;

	public Formulario(ArrayList<Imovel> lista) {
		refLista = lista;
		inicializarComponentes();
	}
	
	public Formulario(ArrayList<Imovel> lista, int id) {
		refLista = lista;
		this.id = id;
		alterar = true;
		inicializarComponentes();
		preparaParaEditar();
	}

	private void preparaParaEditar() {
		Imovel elemento = refLista.get(id);
		txtEndereco.setText(elemento.getEndereco());
		txtArea.setText(String.valueOf(elemento.getMetrosQuadrados()));
		txtQuartos.setText(String.valueOf(elemento.getNumQuartos()));
		txtValor.setText(String.valueOf(elemento.getValorLocacao()));
	}

	protected void inicializarComponentes(){
		declaraForm();

		painel = form.getContentPane();

		declaraLabels();

		declarandoTxtFields();

		definirBotoes();

		form.setVisible(true);
	}

	private void declarandoTxtFields() {
		defineTxtFieldEndereco();
		defineTxtFieldArea();
		defineTxtFieldQuartos();
		defineTxtFieldsValor();
	}

	private void defineTxtFieldsValor() {
		txtValor = new JTextField();
		txtValor.setBounds(150, 120, 230, 25);
		txtValor.setFont(new Font("Verdana", Font.PLAIN, 12));
		txtValor.addKeyListener(new KeyListener() {
			@Override
			public void keyTyped(KeyEvent e) {
				String numeros = "0123456789";
				if (!numeros.contains(e.getKeyChar() + "")){
					e.consume();
				}
			}

			@Override
			public void keyPressed(KeyEvent e) {
				
			}

			@Override
			public void keyReleased(KeyEvent e) {
				validaCampos();
			}
		});
		painel.add(txtValor);			
	}

	private void defineTxtFieldQuartos() {
		txtQuartos = new JTextField();
		txtQuartos.setBounds(150, 90, 230, 25);
		txtQuartos.setFont(new Font("Verdana", Font.PLAIN, 12));
		txtQuartos.addKeyListener(new KeyListener() {
			@Override
			public void keyTyped(KeyEvent e) {
				String numeros = "0123456789";
				if (!numeros.contains(e.getKeyChar() + "")){
					e.consume();
				}
				if(txtQuartos.getText().length() >= 2){
					e.consume();
				}
			}

			@Override
			public void keyPressed(KeyEvent e) {
			}

			@Override
			public void keyReleased(KeyEvent e) {
				validaCampos();
			}
		});
		painel.add(txtQuartos);				
	}

	private void defineTxtFieldArea() {
		txtArea = new JTextField();
		txtArea.setBounds(150, 60, 230, 25);
		txtArea.setFont(new Font("Verdana", Font.PLAIN, 12));
		txtArea.addKeyListener(new KeyListener() {
			@Override
			public void keyTyped(KeyEvent e) {
				String numeros = "0123456789";
				if (!numeros.contains(e.getKeyChar() + "")){
					e.consume();
				}
				if(txtArea.getText().length() >= 6){
					e.consume();
				}
			}

			@Override
			public void keyPressed(KeyEvent e) {
			}

			@Override
			public void keyReleased(KeyEvent e) {
				validaCampos();
			}
		});
		painel.add(txtArea);		
	}

	private void defineTxtFieldEndereco() {
		txtEndereco = new JTextField();
		txtEndereco.setBounds(150, 30, 230, 25);
		txtEndereco.setFont(new Font("Verdana", Font.PLAIN, 12));
		txtEndereco.addKeyListener(new KeyListener() {
			@Override
			public void keyTyped(KeyEvent e) {
			}

			@Override
			public void keyPressed(KeyEvent e) {
			}

			@Override
			public void keyReleased(KeyEvent e) {
				validaCampos();
			}
		});
		painel.add(txtEndereco);
	}

	protected void validaCampos() {
		boolean end, quartos, area, valor;
		end = txtEndereco.getText().length() >= 2;
		quartos = txtQuartos.getText().length() >= 1;
		area = txtArea.getText().length() >= 2;
		valor = txtValor.getText().length() >= 2;
		btnIncluir.setEnabled( end && quartos && area && valor );
	}

	protected void declaraLabels() {
		lblEndereco = new JLabel("Endere�o:");
		lblEndereco.setBounds(25, 30, 100, 25);
		lblEndereco.setForeground(Color.BLUE);
		lblEndereco.setFont(FONT_ARIAL_BOLD);
		
		lblArea = new JLabel("�rea total (m�):");
		lblArea.setBounds(25, 60, 130, 25);
		lblArea.setForeground(Color.BLUE);
		lblArea.setFont(FONT_ARIAL_BOLD);
		
		lblQuartos = new JLabel("Quartos:");
		lblQuartos.setBounds(25, 90, 100, 25);
		lblQuartos.setForeground(Color.BLUE);
		lblQuartos.setFont(FONT_ARIAL_BOLD);
		
		lblValor = new JLabel("Valor loca��o:");
		lblValor.setBounds(25, 120, 130, 25);
		lblValor.setForeground(Color.BLUE);
		lblValor.setFont(FONT_ARIAL_BOLD);
		
		painel.add(lblEndereco);
		painel.add(lblArea);
		painel.add(lblQuartos);
		painel.add(lblValor);
	}

	private void declaraForm() {
		form = new JFrame();
		form.setTitle("Trabalho P1 - CRUD em ArrayList");
		form.setBounds(350, 150, 450, 350);
		form.setLayout(null);
		form.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
	}

	private void definirBotoes() {
		String txtBotao = "Incluir Item";
		if(alterar) 
			txtBotao = "Alterar Item";
		btnIncluir = new JButton(txtBotao);
		btnIncluir.setBounds(120, 170, 200, 25);
		btnIncluir.setEnabled(alterar);
		btnIncluir.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				defineOperacao();
			}
		});
		painel.add(btnIncluir);
	}

	protected void defineOperacao() {
		if(alterar)
			confirmarAlteracao();
		else
			confirmarInclusao();
	}

	private void confirmarAlteracao() {
		Imovel imovel = preparaDadosImovel();
		refLista.set(id, imovel);
		JOptionPane.showMessageDialog(null, "Item alterado!");
	}

	private void confirmarInclusao(){
		Imovel imovel = preparaDadosImovel();
		refLista.add(imovel);
		JOptionPane.showMessageDialog(null,  "Item inclu�do!"); 
	}

	private Imovel preparaDadosImovel() {
		String end = txtEndereco.getText().toString();
		String a, q, v;
		int metros, quartos, valor;
		a = txtArea.getText().toString();
		q = txtQuartos.getText().toString();
		v = txtValor.getText().toString();
		metros = Integer.parseInt(a);
		quartos = Integer.parseInt(q);
		valor = Integer.parseInt(v);
		
		return new Imovel(end, metros, quartos, valor);
	}
}
