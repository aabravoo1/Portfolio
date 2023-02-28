//Andrés Antonio Bravo Orozco
//A01630783
import java.awt.Color;
import java.awt.Graphics;

public class Diana {
	protected int xPos,
				  yPos,
				  ancho;
	protected Color colorCentro; 
	
	public Diana(int xPos, int yPos) {
    		this.xPos = xPos;
    		this.yPos = yPos;
    		this.ancho = 200;
    		this.colorCentro = Color.RED; 
	}
	
	public void setAncho(int ancho) {
		this.ancho = ancho;
	}
	
	public int getAncho() {
		return this.ancho;
	}
	
	public void setColorCentro(Color colorCentro ) {
		this.colorCentro = colorCentro;
	}
	
	public Color getColorCentro() {
		return this.colorCentro;
	}
	
	
	public void setPosicionInicial(int xPos, int yPos) {
		this.xPos = xPos;
		this.yPos = yPos;
	}
	
	public int getX() {
		return this.xPos;
	}
	
	public int getY() {
		return this.yPos;
	}
	

	public void pintaFigura(Graphics g) {
		g.setColor(Color.BLACK);
		g.fillOval(this.xPos , this.yPos , this.ancho , this.ancho);
		g.setColor(Color.WHITE);
		g.fillOval(this.xPos+ancho/12 , this.yPos+ancho/12 , 5*this.ancho/6 , 5*this.ancho/6);
		g.setColor(Color.BLACK);
		g.fillOval(this.xPos+ 2*ancho/12 , this.yPos+2*ancho/12 , 2*this.ancho/3, 2*this.ancho/3);
		g.setColor(Color.WHITE);
		g.fillOval(this.xPos+ 3*ancho/12 , this.yPos+3*ancho/12 , this.ancho/2 , this.ancho/2);
		g.setColor(Color.BLACK);
		g.fillOval(this.xPos+ 4*ancho/12 , this.yPos+4*ancho/12 , this.ancho/3 , this.ancho/3);
		g.setColor(this.colorCentro);
		g.fillOval(this.xPos+ 5*ancho/12 , this.yPos+5*ancho/12 , this.ancho/6 , this.ancho/6);
		
		
		/*
		int n = 6;
		int radio = ancho/6;
		
		for (int i = n; i > 0; i--) {
			if (i%2 == 0) {
				g.setColor(Color.BLACK);
				g.fillOval(this.xPos - i*radio , this.yPos - i*radio, i*2*radio, i*2*radio);
			} else if (i%2 == 1) { 
				g.setColor(Color.WHITE);
				g.fillOval(this.xPos - i*radio , this.yPos - i*radio, i*2*radio, i*2*radio);
				
				if (i == 1) {
					g.setColor(this.colorCentro);
					g.fillOval(this.xPos - i*radio, this.yPos - i*radio, radio*2, radio*2);
				}
			} 		
		}
		*/
	}
}
