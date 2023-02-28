import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;

import javax.swing.JLabel;
import javax.swing.JPanel;

public class DianaPanel extends JPanel implements MouseMotionListener, MouseListener{
	private DianaNumerada dn;
	
	public DianaPanel() {
		super();
		this.setPreferredSize(new Dimension(600, 600));
		
		this.dn = new DianaNumerada(300-200/12, 300-200/12);
		
		this.addMouseListener(this);
		this.addMouseMotionListener(this);
	
	}

	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		this.dn.pintaFigura(g);
		
		
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub
		this.dn.setPosicionInicial(e.getX(), e.getY());
		this.dn.setAncho(0);
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

	@Override
	public void mouseDragged(MouseEvent e) {
		// TODO Auto-generated method stub
		this.dn.setAncho(e.getX() - dn.getX());
		this.repaint();
	}

	@Override
	public void mouseMoved(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}
}
