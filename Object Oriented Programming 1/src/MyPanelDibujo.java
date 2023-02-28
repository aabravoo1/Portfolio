import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;

import javax.swing.ImageIcon;
import javax.swing.JPanel;

public class MyPanelDibujo extends JPanel implements MouseListener, MouseMotionListener {
	private Image fondo;
	private int xV,
				yV,
				xS,
				yS;
				
	private String nombre;
	private boolean mover;
	private Color colorGlobo;
	private BolitaGrafica[] bolita;
	
	public MyPanelDibujo() {
		super();
		Thread hilo2 = new Thread() {
			public void run() {
				System.out.println("hola");
			}
		};
		hilo2.start();
		this.addMouseListener(this);
		this.addMouseMotionListener(this);
		this.setPreferredSize(new Dimension(800, 600));
		this.fondo = new ImageIcon("pocoyo.jpg").getImage();
		this.xV = 0;
		this.yV = 0;
		this.xS = 70;
		this.yS = 515;
		this.nombre = "Pocoyo";		
		mover = false;
		colorGlobo = Color.RED;
		this.bolita = new BolitaGrafica[5];
		for (int i = 0; i < this.bolita.length; i++) {
			this.bolita[i]= new BolitaGrafica();		
		}
		
		Thread hilo = new Thread() {
			public void run() {
				while (xV<=550) {
					try {
						Thread.sleep(10);
						if(mover) {
							xV+=2;
							yV--;
							repaint();//se actualiza la patalla cada vz que se cambia la coordenada
						}
					}
					catch(InterruptedException ex){
							System.out.println("no pude despertar");
						
					}
				}
			}
			
		};//le pasas el metodo run de esta misma clase 
		hilo.start();
	}
	
	public void pintaNave(Graphics g) {
		g.drawImage(this.fondo, 0, 0, this.getWidth(), this.getHeight(), this);
		g.setColor(Color.ORANGE);
		g.fillOval(this.xV+50, this.yV+450, 200, 100);
		g.setColor(Color.cyan);
		g.fillArc(this.xV+50, this.yV+450, 200, 100, 0, 110);
		g.setColor(Color.black);
		g.drawLine(this.xV+100, this.yV+457, this.xV+100, this.yV+400);
		g.setColor(colorGlobo);
		g.fillOval(this.xV+50, this.yV+300, 100, 100);
	}
	
	public void pintaTexto(Graphics g ) {
		g.setColor(Color.RED);
		g.drawString("Vamos "+ this.nombre , this.xS, this.yS);
	}
	
	public void pintaBolitas(Graphics g) {
		for (int i = 0; i < this.bolita.length; i++) {
			this.bolita[i].pinta(g);
			}
	}
	
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		this.pintaNave(g);
		this.pintaTexto(g);
		this.pintaBolitas(g);
		}
	
	
	
	public void setColorGlobo(Color colorGlobo) {
		this.colorGlobo = colorGlobo;
		this.repaint();
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
		this.repaint();
		
	}
	
	public void setyV(int yV) {
		this.yV = yV;
		this.repaint(); 
	}
	
	public void setxV(int xV) {
		this.xV = xV;
		this.repaint(); 
	}
	
	public int getxV() {
		return this.xV;
	}
		
	public int getyV() {
		return this.yV;
	}
		
		//g.drawLine(150, 100, 350, 500);//0,0 esquina superior izquierda, y incrementa ara abajo y x incrementan para la derecha
		//g.setColor(Color.blue);//define el color de la siguiente figura
		//g.fillRect(150, 100, 300, 400);//(coordeada esquina superior izquierda, ), //g.draw lo dibuja, g.fill lo dibuja y lo rellena de un color
		//g.setColor(Color.GREEN);
		//g.drawOval(150, 100, 300, 400);//dibua el ovalo inscrito en el rectangulo que le pases 
		



	@Override
	public void mouseClicked(MouseEvent e) {//se manda llamar cuando se oprime y se libera en la misma coordenada
		mover = true;
	}

	@Override
	public void mousePressed(MouseEvent e) {
		System.out.println("Se presionó");
		
	}

	@Override
	public void mouseReleased(MouseEvent e) {
		System.out.println("Se soltó");
		
	}

	@Override
	public void mouseEntered(MouseEvent e) {
		System.out.println("Entró");
		
	}

	@Override
	public void mouseExited(MouseEvent e) {
		System.out.println("Salió");
		
	}
////////////////////////
	@Override
	public void mouseDragged(MouseEvent e) {
		this.xS = e.getX();
		this.yS = e.getY();
		this.repaint();
		System.out.println(e.getX()+","+e.getY());
		
	}

	@Override
	public void mouseMoved(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}
}
