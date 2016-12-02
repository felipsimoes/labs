package view;

import java.awt.Container;
import java.awt.FlowLayout;
import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.ScrollPaneLayout;
import javax.swing.table.DefaultTableModel;

import business.FormAbstrato;
import business.Imovel;

@SuppressWarnings("serial")
public class FormListaItens extends FormAbstrato {
	private JFrame form;
	private JPanel panel = new JPanel();
	@SuppressWarnings("unused")
	private JLabel lblNome;
	private ArrayList<Imovel> refLista;
	private JTable jTable;
	private JScrollPane jScrollPane;
	private Container painel;
	
	public FormListaItens(ArrayList<Imovel> arrayList) {
		refLista = arrayList;
		inicializarComponentes();
	}

	protected void inicializarComponentes() {
		declaraForm();

		painel = form.getContentPane();
	
		Object[] colunas = {"id", "Endereco", "Metros Quadrados", "Quartos", "Valor"};
		DefaultTableModel tableModel = new DefaultTableModel(colunas, 0);
		jTable = new JTable(tableModel);
		
		int tam = refLista.size();
		for (int i = 0; i < tam; i++) {
			Object dados[] = new Object[5];
			Imovel imovel = refLista.get(i); 
			dados[0] = i;
			dados[1] = imovel.getEndereco();
			dados[2] = imovel.getMetrosQuadrados();
			dados[3] = imovel.getNumQuartos();
			dados[4] = imovel.getValorLocacao();
			tableModel.addRow(dados);
		}

		jTable.setPreferredScrollableViewportSize(jTable.getPreferredSize());
		jTable.setFillsViewportHeight(true);
	    jScrollPane = new JScrollPane(jTable);
	    
	    panel.setLayout(new FlowLayout());
	    jScrollPane.setLayout(new ScrollPaneLayout());
	    painel.add(jScrollPane);
	   
		add(jScrollPane);
		setVisible(true);
	 
		setBounds(350, 150, 400, 300);
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);	
	}

	private void declaraForm() {
		form = new JFrame();
		form.setTitle("Trabalho P1 - CRUD em ArrayList");
			
	}

	@Override
	protected void declaraLabels() {
		
	}
	
}
