//Andrés Antonio Bravo Orozco A01630783
//Mariana González Bravo A01630948

import java.awt.Color;
import java.awt.Dimension;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class SnakeControles extends JPanel {
    private int puntos,
            highscore;
    private JLabel jlPuntos,
            jlHighscore;



    public SnakeControles() {
        super();
        this.setPreferredSize(new Dimension(400,30)); //crea un nuevo panel
        this.setBackground(Color.BLACK);
        this.setLayout(null); //te permite posicionar los labels en la posicion que quieras

        try {
            BufferedReader br = new BufferedReader(new FileReader("snake.txt")); //abre el archivo con highscore
            this.highscore = Integer.parseInt(br.readLine()); //asigna el highscore a la linea leida
            br.close();

        }catch(FileNotFoundException e) { //si no hay archivo
            this.highscore = 0; //hace que tu highscore sea 0
        }catch (IOException ex) {
            System.out.println("Ocurrio un error de I/O" + ex);
        }


        this.jlPuntos = new JLabel("Puntos: " + this.puntos ); //hace el jLabel de los puntos
        this.jlPuntos.setForeground(Color.WHITE);
        this.jlPuntos.setBounds(0, 0, 80, 20); //la posicion del label de los puntos

        this.jlHighscore = new JLabel("Highscore: " + this.highscore);
        this.jlHighscore.setForeground(Color.WHITE);
        this.jlHighscore.setBounds(290, 0, 90, 20);//la posicion del label del highscore

        this.add(this.jlPuntos); //agrega al panel controles los puntos
        this.add(this.jlHighscore); //agrega al panel controles el highscore

    }

    public void setPuntos(int puntos) { //cada que come una bolita asigna otra vez los puntos
        this.puntos = puntos;
        this.jlPuntos.setText("Puntos: " + this.puntos);
        System.out.println(this.puntos);
        this.repaint();
    }

    public void setHighscore() { //cada que hay un nuevo highscore lo lee del documento
        //this.highscore = highscore;
        try {
            BufferedReader br = new BufferedReader(new FileReader("snake.txt"));
            this.highscore = Integer.parseInt(br.readLine());
            br.close();

        }catch(FileNotFoundException e) {
            this.highscore = 0;
        }catch (IOException ex) {
            System.out.println("Ocurrio un error de I/O" + ex);
        }

        this.jlHighscore.setText("Highscore: " + this.highscore); //cambia el highscore al numero leido en el archivo
        this.repaint();
    }

    public int getHighscore() {
        return this.highscore;
    }



}