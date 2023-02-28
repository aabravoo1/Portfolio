import java.awt.Graphics;

public class CreaCuadrado {
	private int x1,
				y1,
				x2,
				y2;
	
	
	public CreaCuadrado(int x, int y) {
		this.x1 = x;
		this.y1 = y;
		this.x2 = x;
		this.y2 = y;
		
	}
	
	public void setX2(int x) {
		this.x2 = x;
	}
	
	public void setY2(int y) {
		this.y2 = y;
	}
	
	
	
	public void pintaCuadrado(Graphics g) {
		g.fillRect(this.x1, this.y1, this.x2-this.x1, this.y2-this.y1);
	}
}
