//Proyecto de Medio Termino "Numerote"
//Agustin Salvador Quintanar de la Mora
//A01636142
//Andrés Antonio Bravo Orozco 
//A01630783
import javax.swing.JFrame;

public class NumeroteVentana extends JFrame{
	
	public NumeroteVentana() {
		super("Numerote");
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		NumeroteControles nc = new NumeroteControles();
		this.add(nc);
		
		this.pack();
		this.setVisible(true);

	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		NumeroteVentana nv = new NumeroteVentana();
	}

}
