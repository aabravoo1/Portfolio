//Andrés Antonio Bravo Orozco A01630783
//Mariana González Bravo A01630948

import java.awt.Color;
import java.awt.Graphics;
import java.util.Random;

public class SnakeBolita { //en este son puros setters y getters de la bolita, pinta la bolita y hace un valor random para la posicion
    private int xBola,
            yBola,
            diametro,
            width,
            height;
    private Random Rndm;

    public SnakeBolita() {
        this.Rndm = new Random();
        this.diametro = 20;

        this.width = 800;
        this.height = 400;

        this.xBola = this.Rndm.nextInt(this.width/20-1)*20; //posiciona una bolita en una posicion random
        this.yBola = this.Rndm.nextInt(this.height/20-1)*20; //posiciona una bolita en una posicion random


    }

    public void paintBolita(Graphics g) {
        g.setColor(Color.YELLOW);
        g.fillOval(this.xBola, this.yBola, this.diametro, this.diametro); //rellena el color de la bolita en la posicion asignada
    }

    public void xRandom() {
        this.xBola = this.Rndm.nextInt(this.width/20-1)*20; //genera una posicion en x random para la bolita
    }

    public void yRandom() {
        this.yBola = this.Rndm.nextInt(this.height/20-1)*20; //genera una posicion en y random para la bolita
    }

    public int getxBola() {
        return xBola; //regresa la posicion random de la bola en x
    }


    public int getyBola() {
        return yBola; //regresa la posicion random  de la bola en y
    }

}