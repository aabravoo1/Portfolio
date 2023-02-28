//Andrés Antonio Bravo Orozco A01630783
//Mariana González Bravo A01630948

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.sound.sampled.*;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.Timer;

public class SnakeGamePanel extends JPanel implements KeyListener, ActionListener {
    private Timer timer;//inicia un timer, programas lo que quieres que haga cada segundo ( o lo que sea el delay) en el action performed
    private int delay = 120;//cuanto tarda en realizar una accion el timer
    private boolean pausa;

    private Color color;


    private List<Snake> snakes; //Un arrayList(clase que te permite hacer listas dinamicas) de snakes

    private SnakeBolita bolita; // la bolita

    private SnakeControles sc;




    public SnakeGamePanel(SnakeControles sc) { //pasas como parametro el snakeControles
        super();
        this.setPreferredSize(new Dimension(800,400));
        this.addKeyListener(this); //para leer las teclas, usa los arrow keys
        this.setFocusable(true); // Es para que se concentre en cada tecla que se pica
        this.setFocusTraversalKeysEnabled(false); // No te deja utilizar keys especiales(ej: tab)
        this.setBackground(Color.DARK_GRAY);

        this.pausa = false;

        this.color = Color.RED;

        this.snakes = new ArrayList<>();
        this.snakes.add(new Snake()); //empieza con un snake

        this.bolita = new SnakeBolita(); //crea una bolita

        this.sc = sc; //inicializa el panel controles

        this.timer = new Timer(this.delay, this); //hace cosas cada cierto delay (como un thread) pero las acciones las pones en el action listener
        timer.start(); //inicializa el timer

        //se inicializan las madres
    }

    public void paint(Graphics g) {
        super.paint(g);
        if (!this.pausa) { //si no esta en pausa pinta el snake
            for (int i = 0; i<this.snakes.size(); i++) {
                this.snakes.get(i).setColor(this.color);
                this.snakes.get(i).paintSnake(g); //pinta el snake
            }

            this.bolita.paintBolita(g); // pinta la bolita
        } else { //si esta en pausa pinta el sumbolo de pausa
            g.setColor(Color.WHITE);
            g.fillRect(370, 170, 20, 60);
            g.fillRect(410, 170, 20, 60);
        }

    }

    public void setColor(Color color) { //setter de color
        this.color = color;
    }

    public void setPausa(boolean pausa) { //cuando eliges el color el programa se pone en pausa
        this.pausa = pausa;
    }

    public void reset() { //cuando le picas a try again
        this.sc.setHighscore(); //modifica el nuevo highscore en el panel
        this.bolita.xRandom(); //escoge un pixel random para la bolita en x
        this.bolita.yRandom(); //escoge un pixel random para la bolita en y

        this.snakes = new ArrayList<>(); //crea un nuevo arrayList para reinicializar el juego en 1
        this.snakes.add(new Snake(800,400)); //agrega un snake en una posicion random

        this.sc.setPuntos(0); //reinicia tus puntos a 0
		/*
		this.intento = 0;
		this.delay = 150;
		this.timer = new Timer(this.delay, this);
		timer.restart();

		*/
    }

    public void keyPressed(KeyEvent e) { //acciones que se hacen cuando se presiona una tecla
        if (e.getKeyCode() == 39) { //si es para la derecha se mueve pa la derecha y nada en "y"
            this.snakes.get(this.snakes.size()-1).setxVel(20);
            this.snakes.get(this.snakes.size()-1).setyVel(0);

            this.repaint();
        }if (e.getKeyCode() == 37) { //izquierda: se mueve a la izquiera en "x" y nada en "y"
            this.snakes.get(this.snakes.size()-1).setxVel(-20);
            this.snakes.get(this.snakes.size()-1).setyVel(0);

            this.repaint();
        } if (e.getKeyCode() == 38) { //arriba: se mueve para arriba en "y" y nada en "x"
            this.snakes.get(this.snakes.size()-1).setxVel(0);
            this.snakes.get(this.snakes.size()-1).setyVel(-20);


            this.repaint();
        } if (e.getKeyCode() == 40) { //abajo: se mueve para abajo en "y" y nada en "x"
            this.snakes.get(this.snakes.size()-1).setxVel(0);
            this.snakes.get(this.snakes.size()-1).setyVel(20);

            this.repaint();

        } if (this.pausa) {
            if (e.getKeyCode() == 32) { //spacebar: si esta en pausa y presionas la spacebar se quita la pausa
                this.pausa = false;//se quita la pausa
                return;
            }
        }if (!this.pausa) {
            if (e.getKeyCode() == 32) { //spacebar: si no esta en pausa y presionas la spacebar se pausa
                this.pausa = true; //esta en pausa
                return;
            }
        }
    }


    public void mover() {
        //variables que guardan la posicion y velocidad de la cabeza en ese instante, sirven solo para que se entienda mejor el codigo
        int x = this.snakes.get(this.snakes.size()-1).getxPos(); //guarda la pos en x de la cabeza
        int y = this.snakes.get(this.snakes.size()-1).getyPos(); //guarda la pos en y de la cabeza
        int xVel = this.snakes.get(this.snakes.size()-1).getxVel(); //guarda la vel en x de la cabeza
        int yVel = this.snakes.get(this.snakes.size()-1).getyVel(); //guarda la vel en y de la cabeza

        for( int i =0 ; i < this.snakes.size()-1; i++) { //mueve a todos de lugar un lugar adelante excepto el valor de hasta el final (la cabeza)
            this.snakes.set(i, this.snakes.get(i + 1));//pone en tu posición i el snake que está adelante de esa posición
        }
        this.snakes.set(this.snakes.size()-1, new Snake(x+xVel,y+yVel,xVel,yVel));//mueve la cabeza un lugar adelante
    }

    public void muerte() {//Si la cabeza toca alguna de las partes de la cola se muere
        //posicion de la cabeza
        int xCabeza = this.snakes.get(this.snakes.size()-1).getxPos();
        int yCabeza = this.snakes.get(this.snakes.size()-1).getyPos();
        int largo = this.snakes.get(this.snakes.size()-1).getSnakeWidth(); //largo del rectangulo
        //posicion del cuerpo
        int xCuerpo;
        int yCuerpo;
        for (int i = 0; i< this.snakes.size()-1; i++) {//checa en cada lugar de la cola despues de su cabeza, también se muere si se va para atras (aunque no se muere si son 2 cuadrados y se va para atras, a partir de 3 si)
            //establece la posicion del cuerpo que vammos a checar si toca la cabeza
            xCuerpo = this.snakes.get(i).getxPos();
            yCuerpo = this.snakes.get(i).getyPos();
            if (new Rectangle(xCabeza,yCabeza,largo,largo).intersects(new Rectangle(xCuerpo,yCuerpo,largo,largo))) { //si la cabeza toca esa posicion de cuerpo, se muere
                System.out.println("muerte");
                /*
                try {// Investigamos como insertar sonidos en la siguiente página: https://www.quora.com/How-do-I-insert-a-sound-clip-in-Java-application-programming
                    File sonido = new File("GameOver.wav" ); //crea un nuevo file sonido
                    AudioInputStream stream; //Crea un nuevo AudioInputStream (stream con un tamaño especifico)
                    AudioFormat format; //crea un nuevo AudioFormat (formato del sonido en bits)
                    DataLine.Info info; //Crea un nuevo DataLine (extends Line.Info)
                    Clip clip; //crea un nuevo Clip
                    stream = AudioSystem.getAudioInputStream(sonido); //inicializa el stram y le pasa el archivo del sonido como parametro
                    format = stream.getFormat(); //inicializa el formato con el formato del archivo
                    info = new DataLine.Info(Clip.class, format); //agrega la informacion del clip a la variable info
                    clip = (Clip) AudioSystem.getLine(info); //convierte el audio system del strem a un clip
                    clip.open(stream);
                    clip.start();
                }
                catch (Exception e) {

                }
                */
                if(JOptionPane.showConfirmDialog(this, "Quieres volver a jugar?", "Moriste", JOptionPane.YES_NO_OPTION) == 0) { //si mueres aparece un mensaje para reiniciar o no el juego
                    reset(); //si es true lo resetea
                } else {
                    System.exit(0); //si es false se cierra el programa
                }

            }
        }
    }

    public void comer() {
        if (new Rectangle(this.snakes.get(this.snakes.size()-1).getxPos(), this.snakes.get(this.snakes.size()-1).getyPos(), this.snakes.get(this.snakes.size()-1).getSnakeWidth(), this.snakes.get(this.snakes.size()-1).getSnakeWidth()).intersects(new Rectangle(this.bolita.getxBola(), this.bolita.getyBola(), this.snakes.get(this.snakes.size()-1).getSnakeWidth(), this.snakes.get(this.snakes.size()-1).getSnakeWidth()))) {
            this.bolita.xRandom(); //escoge un pixel random pa la bolita en x
            this.bolita.yRandom(); //escoge un pixel random pa la bolita en y
            //si tu cabeza intersecta con la bolita crea una snake y la agregea en la posicion de la cabeza

            int x = this.snakes.get(this.snakes.size()-1).getxPos();
            int y = this.snakes.get(this.snakes.size()-1).getyPos();
            int xVel = this.snakes.get(this.snakes.size()-1).getxVel();
            int yVel = this.snakes.get(this.snakes.size()-1).getyVel();
            this.snakes.add(new Snake(x+xVel,y+yVel,xVel,yVel)); // se agrega un snake en la cabeza con la posición de la cabeza anterior mas la velocidad en x y y
			
            
            /*
			this.intento ++;
			if (this.intento == 3) {

				this.delay --;//se hace poquito mas rapido cada 3 veces que comes una bolita
				this.timer = new Timer(this.delay, this);
				timer.restart();
				System.out.println(this.delay);

				this.intento = 0;

			}
				//*/
            this.sc.setPuntos(this.snakes.size() -1); //añade puntos a panel controles
            ////////////////////HIGHSCORE///////////////////////
            if(this.snakes.size()-1 > this.sc.getHighscore()) { //revisa si el score que acabas de obtener es mayor al highscore existente
                try {
                    PrintWriter pw = new PrintWriter(new FileWriter("snake.txt")); //si es true escribe en el archivo de snake tu nuevo highscore
                    pw.println(this.snakes.size()-1);
                    pw.close();
                } catch (IOException e) {
                    System.out.println(e+" Ocurrió un error al guardar el highscore");
                }
            }
            /////////////////////SONIDO/////////////////////////
            /*
            try {// Investigamos como insertar sonidos en la siguiente página: https://www.quora.com/How-do-I-insert-a-sound-clip-in-Java-application-programming
                File sonido = new File("Juego 1.wav" ); //crea un nuevo file sonido
                AudioInputStream stream; //Crea un nuevo AudioInputStream (stream con un tamaño especifico)
                AudioFormat format; //crea un nuevo AudioFormat (formato del sonido en bits)
                DataLine.Info info; //Crea un nuevo DataLine (extends Line.Info)
                Clip clip; //crea un nuevo Clip
                stream = AudioSystem.getAudioInputStream(sonido); //inicializa el stram y le pasa el archivo del sonido como parametro
                format = stream.getFormat(); //inicializa el formato con el formato del archivo
                info = new DataLine.Info(Clip.class, format); //agrega la informacion del clip a la variable info
                clip = (Clip) AudioSystem.getLine(info); //convierte el audio system del strem a un clip
                clip.open(stream);
                clip.start();
            }
            catch (Exception e) {

            }
            */


        }
    }

    public void limites() {
        if (this.snakes.get(this.snakes.size()-1).getxPos() < 0) { // los de aqui son para que no se salga el snake de la ventana
            this.snakes.get(this.snakes.size()-1).setxPos(this.getWidth() - this.snakes.get(0).getSnakeWidth());
        }
        if (this.snakes.get(this.snakes.size()-1).getxPos() > this.getWidth() - this.snakes.get(0).getSnakeWidth()) {
            this.snakes.get(this.snakes.size()-1).setxPos(0);
        }
        if (this.snakes.get(this.snakes.size()-1).getyPos() < 0) {
            this.snakes.get(this.snakes.size()-1).setyPos(this.getHeight() - this.snakes.get(0).getSnakeWidth());
        }
        if (this.snakes.get(this.snakes.size()-1).getyPos() > this.getHeight() - this.snakes.get(0).getSnakeWidth()) {
            this.snakes.get(this.snakes.size()-1).setyPos(0);
        }
    }

    public void actionPerformed(ActionEvent e) {//se llama en cada iteracion del timer
        if (!this.pausa) {
            mover();//mueve el snake
            muerte();//checa si se muere
            comer();//si come el snake agrega un cuadradito, sube los puntos
            limites();// controla si toca un limite el snake
            this.repaint();
        } else {
            this.repaint();
        }
    }

    //metodos de KeyListener que no estamos utilizando
    public void keyTyped(KeyEvent e) {

    }
    public void keyReleased(KeyEvent e) {

    }

}