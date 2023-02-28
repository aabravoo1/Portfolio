import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;

import javax.swing.JPanel;

public class PanelFigura extends JPanel implements MouseListener, MouseMotionListener{
	CreaCuadrado cuadrado;
	
	public PanelFigura() {
		super();
		this.setPreferredSize(new Dimension(600,600));
		this.cuadrado = new CreaCuadrado(200,200);
		
		this.addMouseListener(this);
		this.addMouseMotionListener(this);
		
		
	}
	
	public void setCuadrado(int x, int y) {
		this.cuadrado = new CreaCuadrado(x,y);
	}
	
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		this.cuadrado.pintaCuadrado(g);
		
	}

	@Override
	public void mouseDragged(MouseEvent e) {
		// TODO Auto-generated method stub
		this.cuadrado.setX2(e.getX());
		this.cuadrado.setY2(e.getY());
		this.repaint();
	}

	@Override
	public void mouseMoved(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub
		this.setCuadrado(e.getX(), e.getY());
		System.out.println("x");
		this.repaint();
	}

	@Override
	public void mouseReleased(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseEntered(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseExited(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}
}
