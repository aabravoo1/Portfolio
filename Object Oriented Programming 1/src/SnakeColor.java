//Andrés Antonio Bravo Orozco A01630783
//Mariana González Bravo A01630948

import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.JColorChooser;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class SnakeColor extends JPanel implements MouseListener{
	private JPanel jpColor;
	private JLabel jlColor;
	private Color color;
	
	private SnakeGamePanel sgp;
	
	public SnakeColor(SnakeGamePanel sgp) {
		super();
		this.setPreferredSize(new Dimension(400,30));
		this.setBackground(Color.BLACK);
		this.setLayout(null);
		
		this.sgp = sgp;
		
		this.color = Color.RED;
		
		this.jlColor = new JLabel("Escoge un color");
		//this.jlColor.setHorizontalAlignment(WIDTH/2);
		
		this.jpColor = new JPanel();
		this.jpColor.setBackground(color);
		this.jpColor.setBounds(5, 5, 200, 20);
		this.jpColor.add(jlColor);
		this.jpColor.addMouseListener(this);
		
		this.add(this.jpColor);
	}


	public void mouseClicked(MouseEvent e) {
		this.sgp.setPausa(true);
		this.color = JColorChooser.showDialog(this, "Escoge el color de tu snake", this.color);
		this.sgp.setColor(this.color);
		this.jpColor.setBackground(this.color);
		this.sgp.setPausa(false);
	}
//Métodos de MouseListener sin utilizar  
	public void mousePressed(MouseEvent e) {}
	public void mouseReleased(MouseEvent e) {}
	public void mouseEntered(MouseEvent e) {}
	public void mouseExited(MouseEvent e) {}
	
	
}
