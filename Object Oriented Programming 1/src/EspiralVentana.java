/*EspiralVentana.java
 * Andrés Antonio Bravo Orozco
 * A0163783
 * Comentarios: esta tarea me sirvió mucho para poder comprender los conceptos vistos en clase
 */
import java.awt.BorderLayout;

import javax.swing.JFrame;

public class EspiralVentana extends JFrame{
	public EspiralVentana() {
		super("Espiral");
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		PanelEspiral pe = new PanelEspiral();
		ControlesEspiral ce = new ControlesEspiral(pe);
		
		this.add(pe);
		this.add(ce,BorderLayout.WEST);
		
		this.pack();
		this.setVisible(true);
		
	}
	public static void main(String[] args) {
		EspiralVentana ev = new EspiralVentana();
	}
}
