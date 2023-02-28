import java.awt.BorderLayout;

import javax.swing.JFrame;

public class EstudiarVentana extends JFrame{
	public EstudiarVentana() {
		super("Estudiar");
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		//EstudiarPanel ep = new EstudiarPanel(); 
		//EstudiarControles ec = new EstudiarControles(ep);
		PanelFigura pf = new PanelFigura();
		
		//this.add(ep);
		//this.add(ec, BorderLayout.WEST);
		this.add(pf);
		
		this.pack();
		this.setVisible(true);
	}

	public static void main(String[] args) {
		EstudiarVentana ev = new EstudiarVentana(); 

	}

}
