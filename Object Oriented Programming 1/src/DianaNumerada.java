//Andrés Antonio Bravo Orozco
//A01630783
import java.awt.Color;
import java.awt.Graphics;

public class DianaNumerada extends Diana{

	public DianaNumerada(int xPos, int yPos) {
		super(xPos, yPos);
		
	}
	
	public void agregaNumeros(Graphics g) {
		int xS = this.getX() + this.getAncho()/2-7;
		int yS = this.getY() + this.getAncho()/2+4;
		g.setColor(Color.BLACK);
		g.drawString("10", xS, yS);
		
		xS = this.getX() + this.getAncho()/2 - 4;
		yS = this.getY() + this.getAncho()/2 - this.getAncho()/12 - 2;
		g.setColor(Color.WHITE);
		g.drawString("9", xS, yS);
		          
		yS = this.getY() + this.getAncho()/2 - this.getAncho()/6 - 2;
		g.setColor(Color.BLACK);
		g.drawString("8", xS, yS);
		
		yS = this.getY() + this.getAncho()/2 - 3*this.getAncho()/12 - 2;
		g.setColor(Color.WHITE);
		g.drawString("7", xS, yS);
		
		yS = this.getY() + this.getAncho()/2 - this.getAncho()/3 - 2;
		g.setColor(Color.BLACK);
		g.drawString("6", xS, yS);
		
		yS = this.getY() + this.getAncho()/2 - 5*this.getAncho()/12 - 2;
		g.setColor(Color.WHITE);
		g.drawString("5", xS, yS);
	}
	
	public void pintaFigura(Graphics g) {
		super.pintaFigura(g);
		agregaNumeros(g);
	}
}
