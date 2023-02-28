import javax.swing.JFrame;

public class DianaVentana extends JFrame{
	public DianaVentana() {
		super("Diana Ventana");
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		DianaPanel dp = new DianaPanel();
		
		this.add(dp);
		
		this.pack();
		this.setVisible(true);
	}
	public static void main(String[] args) {
		DianaVentana dv = new DianaVentana();

	}

}
