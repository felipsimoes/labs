package business;

import java.awt.Font;

import javax.swing.JFrame;

@SuppressWarnings("serial")
public abstract class FormAbstrato extends JFrame{
	protected static final Font FONT_ARIAL_BOLD = new Font("Arial", Font.BOLD, 16);
	
	protected abstract void inicializarComponentes();
	
	protected abstract void declaraLabels();
}
