import java.awt.Dimension;
import java.awt.Graphics;

import javax.swing.JPanel;

public class Octagono extends JPanel{
	private int[] x = {175,225,260,260,225,175,140,140,175};
	private int[] y = {100,100,135,185,220,220,185,135,100};
	
	public Octagono() {
		super();
		this.setPreferredSize(new Dimension(400, 400));
		
		
	}
	
	public void paintComponent(Graphics g) {
		g.drawPolyline(this.x, this.y, 9);
	}
}
