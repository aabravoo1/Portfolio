/*PanelEspiral.java
 * Andrés Antonio Bravo Orozco
 * A0163783
 * Comentarios: esta tarea me sirvió mucho para poder comprender los conceptos vistos en clase
 */
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.io.IOException;
import java.lang.*;


import javax.swing.JPanel;



public class PanelEspiral extends JPanel implements Runnable{
	private double r;
	private double radio;
	private int reps = 100;
	private int[] xs = new int[reps];
	private int[] ys = new int[reps];
	private int n;
	private int angle;
	private boolean animacion;
	
	
	public PanelEspiral() {
		super();
		this.setPreferredSize(new Dimension(400, 400));
		this.n = 4;//n
		this.angle = (int) (180 - 180*(n-2)/n);
		this.radio = 5;
		this.setBackground(Color.WHITE);
		this.animacion = false;
		
	}
	
	public void setN(int n) { //Setter de numero de lados
		this.n = n;
		this.angle = (int) (180 - 180*(n-2)/n);
		this.repaint();
	}
	
	public void setReps(int reps) {
		this.reps = reps;
		this.repaint();
	}
	public void setRadio(double radio) {
		this.radio = radio;
		this.repaint();
	}
	
	public void setAnimacion(boolean animacion) {
		this.animacion = animacion;
		Thread hilo = new Thread(this);
		hilo.start();
	}
	
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		for (int i = 0; i < this.reps; i++) {
			this.r = i*this.radio;
			this.xs[i] = (int) (200 + this.r*Math.sin(i*Math.toRadians(this.angle)));
			this.ys[i] = (int) (200 + this.r*Math.cos(i*Math.toRadians(this.angle)));
			/*
			System.out.println(xs[i]);
			System.out.println(ys[i]);
			*/
		}
		
		g.setColor(Color.BLACK);
		g.drawPolyline(xs, ys, this.reps);
	}

	@Override
	public void run() {
		while(this.animacion) {
			try {
				for (int i = 0; i < 20; i++) {
					this.setN(i + 3);
					System.out.println("+" + this.n);
					Thread.sleep(100);
				}
				for (int i = 0; i < 20; i++) {
					this.setN(23 - i);
					System.out.println("-" + this.n);
					Thread.sleep(100);
				}
			}catch(InterruptedException ex) {
				System.out.println("No se pudo despertar");
			}
		}
	}
}
