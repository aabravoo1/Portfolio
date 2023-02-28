import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Graphics;
import javax.swing.JFrame;
import javax.swing.WindowConstants;

public class MyVentana extends JFrame {
	public MyVentana() {
		super("Mi primer ventana en java"); //inicializa en el JFrame 
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);//termina el programa cuando se oprime el boton X, ya que si no se cierra la ventana pero el programa sigue funcionando
		//this.setSize(800, 600);//tamaño de la ventana
		MyPanelDibujo pd = new MyPanelDibujo();
		
		this.add(pd);
		this.add(new MyPanelControles(pd),BorderLayout.WEST);//Se tiene que especificar en donde se agrega ya que sino se agrega al centro donde ya está el panel dibujo
		
		this.pack();//define el fram dependiendo del tamaño de los componentes que definen los mismos
		this.setVisible(true);//se hace visible
		
	}
	
	
	public static void main(String[] args) {
		MyVentana ventana = new MyVentana();
	}

}
