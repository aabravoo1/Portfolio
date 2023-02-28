//Andrés Antonio Bravo Orozco A01630783
//Mariana González Bravo A01630948

import java.awt.Color;
import java.awt.Graphics;
import java.util.Random;

public class Snake { //en este son puros setters y getters del snake y pinta el snake
    private int snakeWidth,
            xPos,
            yPos,
            xVel,
            yVel,
            width,
            height;
    private Random Rndm;
    private Color color;

    public Snake() {
        this.color = Color.RED;
        this.snakeWidth = 20;
        this.xPos = 0;
        this.yPos = 0;
        this.xVel = 20;
        this.yVel = 0;

    }

    public Snake(int xPos, int yPos, int xVel, int yVel) {
        this.snakeWidth = 20;
        this.xPos = xPos;
        this.yPos = yPos;
        this.xVel = xVel;
        this.yVel = yVel;
    }

    public Snake(int width, int height) {
        this.Rndm = new Random();
        this.width = width;
        this.height = height;
        this.xPos = this.Rndm.nextInt(this.width/20-1)*20;
        this.yPos = this.Rndm.nextInt(this.height/20-1)*20;
        this.xVel = 20;
        this.yVel = 0;
    }



    public void paintSnake(Graphics g) {
        g.setColor(this.color);
        g.fillRect(this.xPos, this.yPos, this.snakeWidth, this.snakeWidth); //pinta el cuadrito de la snake
        g.setColor(Color.BLACK);
        g.drawRect(this.xPos, this.yPos, this.snakeWidth, this.snakeWidth);
    }

    public void setColor(Color color) { //setter de color
        this.color = color;
    }

    public int getxPos() { //getter de posicion en x
        return xPos;
    }

    public void setxPos(int xPos) { //setter de posicion en x
        this.xPos = xPos;
    }

    public int getyPos() { //getter de posicion en y
        return yPos;
    }

    public void setyPos(int yPos) { //setter de posicion en y
        this.yPos = yPos;
    }

    public int getxVel() { //getter de velocidad en x
        return xVel;
    }

    public void setxVel(int xVel) { //setter de velocidad en x
        this.xVel = xVel;
    }

    public int getyVel() { //getter de vel en y
        return yVel;
    }

    public void setyVel(int yVel) { //setter de velocidad en y
        this.yVel = yVel;
    }

    public int getSnakeWidth() { //getter de snakewidth
        return snakeWidth;
    }

}