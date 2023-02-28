import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionListener;

import javax.swing.ImageIcon;
import javax.swing.JPanel;

public class EstudiarPanel extends JPanel implements MouseMotionListener{
	Color colorOvalo; 
	int xO;
	int yO;
	Image space;
	
	public EstudiarPanel(){
		super(); 
		this.setPreferredSize(new Dimension(400, 600));
		this.colorOvalo = Color.RED;
		this.xO = 200;
		this.yO = 300;
		this.space = new ImageIcon("space.jpg").getImage();
	
		
		this.addMouseMotionListener(this);
		
	}
	
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		g.drawImage(this.space, 0, 0, this.getWidth(), this.getHeight(), this);
		g.setColor(this.colorOvalo);
		g.fillOval(this.xO - this.getWidth()/8 , this.yO - this.getWidth()/8, this.getWidth()/4, this.getHeight()/4);
		
		
	}
	
	public void setColorOvalo(Color color){
		this.colorOvalo = color;
		this.repaint();
	}
	
	public Color getColorOvalo() {
		return this.colorOvalo;
	}
	
	public int getXO() {
		return this.xO;
	}
	
	public int getYO() {
		return this.yO;
	}
	
	public void setX(int x) {
		this.xO = x;
		this.repaint();
	}
	
	public void setY(int y) {
		this.yO = y;
		this.repaint();
	}

	@Override
	public void mouseDragged(MouseEvent e) {
		this.xO = e.getX();
		this.yO = e.getY(); 
		this.repaint();

				
	}

	@Override
	public void mouseMoved(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}
	
}
