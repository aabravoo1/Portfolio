
/**
 * Proyecto Final de Estructuras de Datos
 * Ventana para Arbol AVL
 * @author Andres Antonio Bravo Orozco A01630783
 * @author Jean Carlo Alvarez Guerra A01635182
 * Ventana.java
 */

import java.awt.BorderLayout;
import javax.swing.JFrame;
public class Ventana extends JFrame{
	
	/**
	 * Constructor de Ventana
	 * Incializa sus caracteristica y funcionalidad y agrega los paneles.
	 */
	public Ventana() {
		super("Árbol AVL");
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		Panel p = new Panel();
		this.add(p);
		this.add(new PanelControles(p), BorderLayout.SOUTH);
		this.pack();
		this.setLocationRelativeTo(null);
		this.setResizable(false);
		this.setVisible(true);
	}
	
	public static void main(String[] args) {
		Ventana v = new Ventana();
	}
}
