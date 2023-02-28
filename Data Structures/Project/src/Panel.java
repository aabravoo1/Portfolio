

/**
 * Proyecto Final de Estructuras de Datos
 * Panel para simulador de Arbol AVL.
 * Esta clase crea y programa el panel donde se va a pintar el arbol. 
 * @author Andres Antonio Bravo Orozco A01630783
 * @author Jean Carlo Alvarez Guerra A01635182
 * Panel.java
 */


import java.awt.Dimension;
import java.awt.Graphics;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import javax.swing.JPanel;

public class Panel extends JPanel{
	private MyAVL<Integer> arbolInteger;
	private MyAVL<String>  arbolString;
	private MyAVL<Double>  arbolDouble;
	int sel;
	int tipo;
 	
	/**
	 * Constructor del Panel.
	 * Inicializa tres arbol de tipo Integer, String y Double 
	 * respectivamente simplemente como ejemplo para el usuario. 
	 */
	public Panel() {
		super();
		this.setPreferredSize(new Dimension(1300,400));
		this.setFocusable(true);
		this.arbolInteger = new MyAVL<>();
		this.arbolString  = new MyAVL<>();
		this.arbolDouble  = new MyAVL<>();
		this.sel = 0;
		this.tipo = 3;
		
		this.arbolInteger.insert(21);
		this.arbolInteger.insert(13);
		this.arbolInteger.insert(33);
		this.arbolInteger.insert(10);
		this.arbolInteger.insert(18);
		this.arbolInteger.insert(25);
		this.arbolInteger.insert(40);
		this.arbolInteger.insert(29);
		/*this.arbolInteger.insert(27);
		this.arbolInteger.insert(30);
		this.arbolInteger.insert(1);
		this.arbolInteger.insert(11);
		this.arbolInteger.insert(15);
		this.arbolInteger.insert(22);
		this.arbolInteger.insert(35);
		this.arbolInteger.insert(19);
		this.arbolInteger.insert(45);
		this.arbolInteger.insert(34);
		this.arbolInteger.insert(200);
		*/
		this.arbolString.insert("Hola");
		this.arbolString.insert("Arbol String");
		this.arbolString.insert("Proyecto");
		this.arbolString.insert("Arbol AVL");
		
		this.arbolDouble.insert(28.9);
		this.arbolDouble.insert(34.5676);
		this.arbolDouble.insert(27.123433);
		this.arbolDouble.insert(1.0);
		this.arbolDouble.insert(10.234345);
		
		
		
		
	}
	
	/**
	 * Se encarga de pintar el arbol actual del tipo seleccionado en el panel.
	 */
	public void paint(Graphics g) {
		super.paint(g);
		if(this.sel == 0) {
			arbolInteger.pintaArbol(g, this.getWidth()/2, this.getWidth()/2, 20);
		}else if(this.sel == 1) {
			arbolString.pintaArbol(g, this.getWidth()/2, this.getWidth()/2, 20);
		}else {
			arbolDouble.pintaArbol(g, this.getWidth()/2, this.getWidth()/2, 20);
		}
		if(this.tipo == 0) {
			if(this.sel == 0) {
				g.drawString(this.arbolInteger.preorden(), 2, this.getHeight()-5);
			}else if(this.sel == 1) {
				g.drawString(this.arbolString.preorden(), 2, this.getHeight()-5);
			}else {
				g.drawString(this.arbolDouble.preorden(), 2, this.getHeight()-5);
			}
		}else if(this.tipo == 1) {
			if(this.sel == 0) {
				g.drawString(this.arbolInteger.inorden(), 2, this.getHeight()-5);
			}else if(this.sel == 1) {
				g.drawString(this.arbolString.inorden(), 2, this.getHeight()-5);
			}else {
				g.drawString(this.arbolDouble.inorden(), 2, this.getHeight()-5);
			}
		}else if(this.tipo == 2){
			if(this.sel == 0) {
				g.drawString(this.arbolInteger.postorden(), 2, this.getHeight()-5);
			}else if(this.sel == 1) {
				g.drawString(this.arbolString.postorden(), 2,this.getHeight()-5);
			}else {
				g.drawString(this.arbolDouble.postorden(), 2, this.getHeight()-5);
			}
		}else {
			
		}
		
	}
	
	/**
	 * Repinta cada vez que se hace una insercion en el arbol de Integer
	 * @param valor el elemento a agregar
	 */
	public void insertInteger(int valor) {
		this.arbolInteger.insert(valor);
		repaint();
	}
	
	/**
	 * Repinta cada vez que se hace una insercion en el arbol de String
	 * @param valor el elemento a agregar
	 */
	public void insertString(String valor) {
		this.arbolString.insert(valor);
		repaint();
	}
	
	/**
	 * Repinta cada vez que se hace una insercion en el arbol de Double
	 * @param valor el elemento a agregar
	 */
	public void insertDouble(double valor) {
		this.arbolDouble.insert(valor);
		repaint();
	}
	
	/**
	 * Repinta cada vez que se hace una eliminacion en el arbol de Integer
	 * @param valor el elemento a eliminar
	 */
	public void removeInteger(int valor) {
		this.arbolInteger.remove(valor);
		repaint();
	}
	
	/**
	 * Repinta cada vez que se hace una eliminacion en el arbol de String
	 * @param valor el elemento a eliminar
	 */
	public void removeString(String valor) {
		this.arbolString.remove(valor);
		repaint();
	}
	
	/**
	 * Repinta cada vez que se hace una eliminacion en el arbol de Double
	 * @param valor el elemento a eliminar
	 */
	public void removeDouble(double valor) {
		this.arbolDouble.remove(valor);
		repaint();
	}
	
	/**
	 * Realiza un flush en el arbol de Integer y repinta el panel. 
	 */
	public void flushInteger() {
		this.arbolInteger.flush();
		repaint();
	}
	
	/**
	 * Realiza un flush en el arbol de String y repinta el panel. 
	 */
	public void flushString() {
		this.arbolString.flush();
		repaint();
	}
	
	/**
	 * Realiza un flush en el arbol de Double y repinta el panel. 
	 */
	public void flushDouble() {
		this.arbolDouble.flush();
		repaint();
	}

	/**
	 * Getter del tipo de arbol que se esta simulando en ese momento. 
	 * @return 0 para Integer, 1 para String, 2 para Double
	 */
	public int getSel() {
		return sel;
	}
	
	/**
	 * Setter del tipo de arbol que se esta simulando en ese momento. 
	 * @param sel el tipo de arbol que se quiere simular.
	 */
	public void setSel(int sel) {
		this.sel = sel;
	}
	
	/**
	 * Setter de tipo
	 * @param tipo es el tipo de recorrido que se quiere realizar.
	 */
	public void setTipo(int tipo) {
		this.tipo = tipo;
		//System.out.println(this.tipo);
	}
	
}