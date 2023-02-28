//Andrés Antonio Bravo Orozco A01630783
//Mariana González Bravo A01630948

import java.awt.BorderLayout;
import java.awt.GridLayout;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class SnakeVentana extends JFrame{

    public SnakeVentana(){
        super("Snake game");
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);

        SnakeControles sc = new SnakeControles(); // se crea el objeto de SnakeControles
        SnakeGamePanel sgp =  new SnakeGamePanel(sc); //se crea el objeto SnakeGamePanel y se le pasa como parametro SnakeControles
        SnakeColor scolor = new SnakeColor(sgp); // Se crea el objeto SnakeColor y se le pasa como parametro SnakeGamePanel

        JPanel jp = new JPanel(); //Se crea un nuevo JPanel que contiene SnakeGamePanel y SnakeControles

        jp.setLayout(new GridLayout(1,2)); // el JPanel se divide en dos columnas
        jp.add(scolor); //se añade en la primera columna SnakeColor
        jp.add(sc); //Se añade en la segunda columna SnakeControles

        this.add(sgp); // Se agrega a la ventana el SnakeGamePanel
        this.add(jp, BorderLayout.NORTH);//Se agrega a la ventana el SnakeJPanel en el norte

        this.pack();
        this.setResizable(false); //No pertite que el usuario modifique el tamaño de la ventana
        this.setVisible(true);

    }

    public static void main(String[] args) {
        SnakeVentana sv = new SnakeVentana();
    }
}