/**
 * Proyecto Final de Estructuras de Datos
 * Implementacion Generica de Arbol AVL.
 * Incluye adicionalmente los metodos necesarios para llevar a cabo la simulador con GUI del arbol. 
 * @author Andres Antonio Bravo Orozco A01630783
 * @author Jean Carlo Alvarez Guerra A01635182
 * PanelControles.java
 */

import java.awt.Color;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.util.NoSuchElementException;

public class MyAVL<E extends Comparable<E>> {
	private MyNodoAVL<E> root;
	private int size;
	
	/**
	 * Constructor de MyAVL. 
	 * Inicializa el arbol vacio, con todos los atributos con su valor default.
	 */
	public MyAVL() {
		super();
	}
	
	/**
	 * El m�todo predecesor encuentra el "mayor de los menores" en un �rbol binario de b�squeda
	 * 
	 * @param root2 el nodo del cual se quiere calcular el predecesor
	 * @return nodo predecesor al nodo current
	 */
	private MyNodoAVL<E> predecesor(MyNodoAVL<E> root2){
		MyNodoAVL<E> predecesor=root2.left;
		while(predecesor.right != null) {
			predecesor = predecesor.right;
		}
		return predecesor;
	}
	/**
	 * El m�todo remove elimina el nodo que contiene el dato "valor"
	 * Considera 3 casos claves: cuando el nodo no tiene hijos, tiene 
	 * 1 solo hijo o tiene 2 hijos
	 * @param valor el dato a borrar del �rbol
	 * @return el valor eliminado del �rbol
	 * @throws NoSuchElementException si el �rbol est� vac�o
	 * @throws NullPointerException si el valor que se busca no est� en el �rbol
	 */
	public E remove(E valor) {
		try {
			if(this.root == null) {
				throw new NoSuchElementException("No se puede encontrar el valor "+valor+" en un �rbol vac�o");
			}else if(this.root.valor == valor){
				//borrar la raiz
				E resultado = root.valor;
				//Caso cuando no tiene hojas
				if(root.left == null && root.right == null) {	
					this.root = null;
				//caso cuando tiene un hijo derecho
				}else if(root.left == null) {
					this.root = root.right;
				//caso cuando tiene un hijo izquierdo
				}else if(root.right == null) {
					this.root = root.left;
				//caso cuando el nodo a borrar tiene 2 hijos
				}else{
					E tmpPredecesor = predecesor(this.root).valor; 
					this.root.setValor(remove(tmpPredecesor));
					this.size++;
				}
				this.size--;
				return resultado;
			}
			else {
				MyNodoAVL<E> parent = null; //parent sobre nodo a borrar
				MyNodoAVL<E> current = this.root;
				while(!current.valor.equals(valor)) {
					//Cuando el valor no est[a se arroja un NullPointerException
					parent = current; 
					if(valor.compareTo(current.valor) < 0) {
						current = current.getLeft();
					}else {
						current = current.getRight();
					}
				}
				//aqu[i ya tengo a current apuntando al nodo a borrar y a parent apuntando al padre de current
				//throw new NoSuchElementException("No se puede encontrar el valor "+valor+" en el �rbol");
				//Caso nodo a borrar son hojas
				E resultado = current.valor;
				if(current.left == null && current.right == null) {	
					if(valor.compareTo(parent.valor)<0) {
						parent.setLeft(null);
						current.setParent(null);
					}else {
						parent.setRight(null);
						current.setParent(null);
					}
				//caso cuando tiene un hijo derecho
				}else if(current.left == null) {
					if(valor.compareTo(parent.valor)<0) {
						parent.setLeft(current.right);
						current.setParent(null);
					}else {
						parent.setRight(current.right);
						current.setParent(null);
					}
				//caso cuando tiene un hijo izquierdo
				}else if(current.right == null) {
					if(valor.compareTo(parent.valor)<0) {
						parent.setLeft(current.left);
						current.setParent(null);
					}else {
						parent.setRight(current.left);
						current.setParent(null);
					}
				//caso cuando el nodo a borrar tiene 2 hijos
				}else{
					E tmpPredecesor = predecesor(current).valor; 
					current.setValor(remove(tmpPredecesor));
					current.setParent(null);
					this.size++;
				}
				this.size--;
				actualizarEliminacion(parent);
				return resultado;
			}
			
		}catch(NullPointerException ex){
			throw new NullPointerException("El valor "+valor+" no se encuentra en el arbol");
		}

	}
	
	/**
	 * Inserta un nuevo elemento en el árbol.
	 * No acepta elementos repetidos.
	 * @param dato es el elemento que se desea insertar.
	 */
	public void insert(E dato) {
		MyNodoAVL<E> nuevo = new MyNodoAVL<>(dato);
		MyNodoAVL<E> prev = null;
		if(this.root==null) {
			this.root = nuevo;
		}else {
			MyNodoAVL<E> current = this.root;
			
			while(current!=null) { 
				prev=current;
				if(dato.equals(current.valor)) {
					return;
				}else if(dato.compareTo(current.valor)<0) {
					current=current.left;
				}else {
					current=current.right;
				}
			}
			//prev apunta al padre, current apunta a null.
			if(dato.compareTo(prev.valor)<0) {
				prev.left=nuevo;
				nuevo.parent=prev;
			}else {
				prev.right=nuevo;
				nuevo.parent=prev;
			}
			
			actualizar(nuevo.parent); //deberia ser con prev o nuevo.parent como argumento pero me manda nullpointerexception.
			
			
		}
		this.size++;
	}
	
	/**
	 * Calcula los nuevos factores de balanceo luego insertar un nuevo elemento.
	 * Determina si se necesita realizar rotacion simples o dobles y manda a llamar a sus funciones en caso tal. 
	 * Realiza su funcion de forma recursiva. 
	 * @param current es el nodo a partir del cual se deben actualizar factores. 
	 */
	public void actualizar(MyNodoAVL<E> current) {
		current.factor=factor(current);
		if(current.factor == 0) {
			return;
		}else if(Math.abs(current.factor)==1 && current.parent != null) {
			actualizar(current.parent);
		}else {//se necesita rotacion
			if(current.factor==-2 && current.left != null) {
				current.left.factor = factor(current.left);
			}if(current.factor==2 && current.right != null) {
				current.right.factor = factor(current.right);
			}
			if(current.factor==-2 && current.left != null && current.left.factor==-1) { //rotacion simple a la derecha
				RSD(current);
			}else if(current.factor==2 && current.right != null && current.right.factor==1) { //rotacion simple a la izquierda
				RSI(current);
			}else if(current.factor==-2 && current.left != null && current.left.factor==1) { //rotacion doble a la derecha
				RDD(current);
			}else if(current.factor==2 && current.right != null && current.right.factor==-1){//rotacion doble a la izquierda
				RDI(current);
			}
		}
	}
	
	/**
	 * Calcula los nuevos factores de balanceo luego de eliminar un elemento.
	 * Determina si se necesita realizar rotacion simples o dobles y manda a llamar a sus funciones en caso tal.
	 * Realiza su funcion de manera recursiva.  
	 * @param current es el nodo a partir del cual se deben actualizar factores. 
	 */
	public void actualizarEliminacion(MyNodoAVL<E> current) {
		current.factor=factor(current);
		if(Math.abs(current.factor)==1) {
			return;
		}else if(current.factor==0) {
			if(current.parent != null) {
				actualizarEliminacion(current.parent);
			}if(current.left != null) {
				actualizar(current.left);
			}if(current.right != null) {
				actualizar(current.right);
			}else {
				return;
			}
		}else {//se necesita rotacion
			if(current.factor==-2 && current.left != null) {
				current.left.factor = factor(current.left);
			}if(current.factor==2 && current.right != null) {
				current.right.factor = factor(current.right);
			}
			if(current.factor==-2 && current.left != null && current.left.factor==-1 | current.left.factor==0) { //rotacion simple a la derecha
				RSD(current);
				actualizarEliminacion(current);
			}else if(current.factor==2 && current.right != null && current.right.factor==1 | current.right.factor==0) { //rotacion simple a la izquierda
				RSI(current);
				actualizarEliminacion(current);
			}else if(current.factor==-2 && current.left != null && current.left.factor==1) { //rotacion doble a la derecha
				RDD(current);
				actualizarEliminacion(current);
			}else if(current.factor==2 && current.right != null && current.right.factor==-1){//rotacion doble a la izquierda
				RDI(current);
				actualizarEliminacion(current);
			}
		}
	}
	
	/**
	 * Realiza una rotacion simple a la derecha. 
	 * @param pivote es el nodo eje de referencia que se usa para realizar la rotacion.
	 */
	private void RSD(MyNodoAVL<E> pivote) {
		if(pivote.parent == null) {
			this.root = pivote.left;
			pivote.left.parent=null;
			pivote.parent=pivote.left;
			pivote.left=pivote.left.right;
			pivote.parent.right=pivote;
			if(pivote.left != null) {
				pivote.left.parent=pivote;
			}
		}else {
			if(pivote.parent.left== pivote) {
				pivote.parent.left=pivote.left;
			}else {
				pivote.parent.right=pivote.left;
			}
			pivote.left.parent=pivote.parent;
			pivote.parent=pivote.left;
			pivote.left=pivote.left.right;
			pivote.parent.right=pivote;
			if(pivote.left != null) {
				pivote.left.parent=pivote;
			}
		}
		
	}
	
	/**
	 * Realiza una rotacion simple a la izquierda. 
	 * @param pivote es el nodo eje de referencia que se usa para realizar la rotacion.
	 */
	private void RSI(MyNodoAVL<E> pivote) {
		if(pivote.parent == null) {
			this.root = pivote.right;
			pivote.right.parent=null;
			pivote.parent=pivote.right;
			pivote.right=pivote.right.left;
			pivote.parent.left=pivote;
			if(pivote.right != null) {
				pivote.right.parent=pivote;
			}
		}else {
			if(pivote.parent.left== pivote) {
				pivote.parent.left=pivote.right;
			}else {
				pivote.parent.right=pivote.right;
			}
			pivote.right.parent=pivote.parent;
			pivote.parent=pivote.right;
			pivote.right=pivote.right.left;
			pivote.parent.left=pivote;
			if(pivote.right != null) {
				pivote.right.parent=pivote;
			}
		}
	}
	
	/**
	 * Realiza una rotacion doble a la derecha. 
	 * Manda a llamar las funciones de RSI y RSD en el orden y con los nodos adecuados. 
	 * @param pivote es el nodo eje de referencia que se usa para realizar la rotacion.
	 */
	private void RDD(MyNodoAVL<E> pivote) {
		RSI(pivote.left);
		RSD(pivote);
	}
	
	/**
	 * Realiza una rotacion doble a la izquierda. 
	 * Manda a llamar las funciones de RSI y RSD en el orden y con los nodos adecuados. 
	 * @param pivote es el nodo eje de referencia que se usa para realizar la rotacion.
	 */
	private void RDI(MyNodoAVL<E> pivote) {
		RSD(pivote.right);
		RSI(pivote);
	}
	
	/**
	 * Calcula la altura maxima de cualquier nodo, es decir, 
	 * la cantidad de niveles debajo de si mismo.  
	 * @param current el nodo del cual se quiere calcular su altura maxima. 
	 * @return la altura maxima del nodo. 
	 */
    public int altura(MyNodoAVL<E> current)  
    { 
        if (current == null) 
            return 0; 
        else 
        { 
            int hIzq = altura(current.left); 
            int hDer = altura(current.right); 
   
            if (hIzq > hDer) 
                return (hIzq + 1); 
             else 
                return (hDer + 1); 
        } 
    } 
    
    /**
     * Calcula el factor de balanceo de cualquier nodo. 
     * Utiliza el metodo altura para realizar el calculo. 
     * @param nodo elemento del cual se quiere saber su factor de balanceo
     * @return factor de balanceo de current.
     */
    public int factor(MyNodoAVL<E> nodo) {
    	return altura(nodo.right)-altura(nodo.left);
    }
    
    /**
     * Realiza e imprime un recorrido por nivel de todo el arbol.
     *
	public void nivel() {
		QueueLE<MyNodoAVL<E>> cola = new QueueLE<>(); 
		cola.enqueue(this.root);
		while(!cola.isEmpty()) {
			if(cola.next().left!=null) {
				cola.enqueue(cola.next().left);
			}
			if(cola.next().right!=null) {
				cola.enqueue(cola.next().right);
			}
			MyNodoAVL nodo = cola.dequeue();
			System.out.print(nodo+"|"+nodo.factor+",");
		}
	}*/
	
	/**
	 * El m�todo preorden privado es el m�todo recursivo para recorrer el �rbol
	 * binario con el m�todo de preorden. Imprime primero la ra�z, despu�s el nodo
	 * izquierdo y despu�s el nodo derecho
	 * @param current el nodo que se est� recorriendo actualmente, habilita llamada recursiva
	 */
	private String preorden(MyNodoAVL<E> current, String str) {
		if(current != null) {
			str = str + current.valor+",";
			str = preorden(current.left, str);
			str = preorden(current.right, str);
		}return str;
	}
	/**
	 * El m�todo preorden p�blico es el m�todo de preparaci�n para el m�todo preorden
	 * privado
	 */
	public String preorden() {
		return preorden(this.root,"");
		
	}
	
	/**
	 * El m�todo inorden privado es el m�todo recursivo para recorrer el �rbol
	 * binario con el m�todo de inorden. Imprime primero el nodo izquierdo, despu�s
	 * el nodo raiz y al final el nodo izquierdo
	 * @param current el nodo que se est� recorriendo actualmente, habilita llamada recursiva
	 */
	private String inorden(MyNodoAVL<E> current, String str) {
		if(current != null) {
			str = inorden(current.left, str);
			str = str + current.valor+",";
			str = inorden(current.right, str);
		}return str;
	}
	
	/**
	 * El m�todo inorden p�blico es el m�todo de preparaci�n para el m�todo inorden
	 * privado
	 */
	public String inorden() {
		return inorden(this.root,"");
	}
	
	/**
	 * El m�todo postorden privado es el m�todo recursivo para recorrer el �rbol
	 * binario con el m�todo de postorden. Imprime primero el nodo izquierdo, despu�s
	 * el nodo derecho y al final el nodo raiz
	 * @param current el nodo que se est� recorriendo actualmente, habilita llamada recursiva
	 */
	private String postorden(MyNodoAVL<E> current, String str) {
		if(current != null) {
			str = postorden(current.left,str);
			str = postorden(current.right,str);
			str = str + current.valor+",";
		}return str;
	}
	
	/**
	 * El m�todo postorden p�blico es el m�todo de preparaci�n para el m�todo postorden
	 * privado
	 */
	public String postorden() {
		return postorden(this.root,"");
	}
	
	/**
	 * Pinta el arbol en el panel. 
	 * @param g instanciacion en el panel de la clase abstracta Graphics.
	 * @param referencia es la posicion base donde se comienza a pintar el arbol.
	 * @param x posicion en x donde se va a pintar el arbol 
	 * @param y posicion en x donde se va a pintar el arbol
	 */
	public void pintaArbol(Graphics g,int referencia, int x, int y) {
		preordenGraphicR(g,this.root,referencia,x,y);
	}
	
	/**
	 * Pinta cada nodo del arbol, realizando un recorrido tipo preorden. 
	 * @param g instanciacion en el panel de la clase abstracta Graphics. 
	 * @param current nodo a pintar.
	 * @param referencia es la posicion base donde se comienza a pintar el arbol.
	 * @param x posicion en x donde se va a pintar el siguiente nodo. 
	 * @param y posicion en y donde se va a pintar el siguiente nodo. 
	 */
	private void preordenGraphicR(Graphics g, MyNodoAVL<E> current, int referencia, int x, int y) {
		if(current != null) {
			current.paintNodo(g, x, y);
			g.setColor(Color.black);
			if(current.left != null)
				if(current.getValor().toString().length() < 3) {
					g.drawLine(x, y+10, x - referencia/2 + 20, y + 50);
				}else {
					FontMetrics metrics = g.getFontMetrics();
					int adv = metrics.stringWidth(current.left.getValor().toString());
					g.drawLine(x, y+10, x - referencia/2 + adv+8, y + 50);
				}
				
			
			if(current.right != null)
				if(current.getValor().toString().length() < 3) {
					g.drawLine(x+20, y+10, x + referencia/2, y + 50);
				}else {
					FontMetrics metrics = g.getFontMetrics();
					int adv = metrics.stringWidth(current.getValor().toString());
					g.drawLine(x+adv+8, y+10, x + referencia/2, y + 50);
				}
			preordenGraphicR(g, current.left,  referencia/2, x - referencia/2, y + 40);
			preordenGraphicR(g, current.right, referencia/2, x + referencia/2, y + 40);
		}
	}
	
	/**
	 * Borra todos los elementos del arbol. 
	 */
	public void flush() {
		this.root = null;
		this.size = 0;
		System.gc();
	}
    
    public static void main(String[] args) {
    	/*
		MyAVL<Integer> arbol = new MyAVL<>();
		arbol.insert(21);
		arbol.insert(13);
		arbol.insert(33);
		arbol.insert(10);
		arbol.insert(18);
		arbol.insert(25);
		arbol.insert(40);
		arbol.insert(29);
		arbol.insert(27);
		//arbol.nivel();
		System.out.println(arbol.preorden());
		System.out.println(arbol.inorden());
		System.out.println(arbol.postorden());
		
		arbol.remove(25);
		arbol.nivel();
		System.out.println();
		
		arbol.remove(40);
		arbol.nivel();
		System.out.println();
		
		arbol.insert(2);
		arbol.remove(18);
		arbol.nivel();
		System.out.println();
		
		arbol.insert(5);
		arbol.remove(13);
		arbol.nivel();
		System.out.println();
		
		arbol.flush();
		arbol.insert(35);
		arbol.insert(33);
		arbol.insert(45);
		arbol.insert(30);
		arbol.insert(34);
		arbol.nivel();
		System.out.println();
		
		arbol.remove(45);
		arbol.nivel();
		System.out.println();
		
		arbol.flush();
		arbol.insert(21);
		arbol.insert(13);
		arbol.insert(33);
		arbol.insert(10);
		arbol.insert(18);
		arbol.insert(25);
		arbol.insert(40);
		arbol.insert(29);
		arbol.insert(27);
		arbol.insert(30);
		arbol.insert(1);
		arbol.insert(11);
		arbol.insert(15);
		arbol.insert(22);
		arbol.insert(35);
		arbol.insert(19);
		arbol.insert(45);
		arbol.insert(34);
		arbol.insert(200);
		arbol.nivel();
		System.out.println();
		
		arbol.remove(200);
		arbol.remove(40);
		arbol.remove(45);
		arbol.nivel();
		System.out.println();*/
	}
	
	
	
}


class MyNodoAVL<E>{
	MyNodoAVL<E> left,
				 right,
				 parent;
	E valor;
	int factor;
	
	/**
	 * Constructor de MyNodoAVL.
	 * Inicializa el nodo con un valor dado y sin nodos hijos.
	 * @param valor es el dato que se desea almacenar en el elemento.
	 */
	public MyNodoAVL(E valor) {
		this(valor,null,null,null);
	}
	
	/**
	 * Constructor de MyNodoAVL.
	 * Inicializa el nodo con un valor y con sus dos respectivos nodos hijos y su padre.
	 * @param valor es el dato que se desea almacenar en el elemento.
	 * @param left  es el nodo que ser� el hijo de la izquierda
	 * @param right es el nodo que ser� el hijo de la derecha.
	 * @param parent es el nodo que es su padre.
	 */
	public MyNodoAVL(E valor, MyNodoAVL<E> left, MyNodoAVL<E> right, MyNodoAVL<E> parent) {
		this.valor = valor;
		this.left=left;
		this.right=right;
		this.parent = parent;
		this.factor=0;
	}
	
	/**
	 * Getter del atributo parent
	 * @return el nodo padre del nodo actual
	 */
	public MyNodoAVL<E> getParent() {
		return parent;
	}

	/**
	 * Setter del atributo parent
	 * @param parent es el nodo que se quiere referenciar como padre.
	 */
	public void setParent(MyNodoAVL<E> parent) {
		this.parent = parent;
	}
	
	/**
	 * Getter del atributo left.
	 * @return el nodo hijo izquierdo.
	 */
	public MyNodoAVL<E> getLeft() {
		return left;
	}

	/**
	 * Setter del atributo left.
	 * @param left el nuevo nodo que ser� el hijo izquierdo. 
	 */
	public void setLeft(MyNodoAVL<E> left) {
		this.left = left;
	}

	/**
	 * Getter del atributo right.
	 * @return el nodo hijo derecho.
	 */
	public MyNodoAVL<E> getRight() {
		return right;
	}

	/**
	 * Setter del atributo right.
	 * @param right el nuevo nodo que ser� el hijo derecho. 
	 */
	public void setRight(MyNodoAVL<E> right) {
		this.right = right;
	}

	/**
	 * Getter del atributo valor.
	 * @return el dato que contiene el nodo.
	 */
	public E getValor() {
		return valor;
	}

	/**
	 * Setter del atributo valor.
	 * @param valor es el nuevo dato a almacenar.
	 */
	public void setValor(E valor) {
		this.valor = valor;
	}
	
	/**
	 * Regresa la representaci�n en String del nodo.
	 * @return el valor contenido en el nodo en String.
	 */
	public String toString() {
		return this.valor.toString();
	}	
	
	/**
	 * Dibuja el nodo en el panel
	 * @param g instanciacion en el panel de la clase abstracta Graphics
	 * @param x posicion en x donde se pinta el nodo
	 * @param y posicion en y donde se pinta el nodo
	 */
	public void paintNodo(Graphics g, int x, int y) {
		g.setColor(Color.blue);
		if(valor.toString().length() == 1) {
			g.drawString(valor.toString(), x+7, y+15);
			g.drawOval(x, y, 20, 20);
		}else if(valor.toString().length() == 2) {
			g.drawString(valor.toString(), x+3, y+15);
			g.drawOval(x, y, 20, 20);
		}else {
			FontMetrics metrics = g.getFontMetrics();
			int adv = metrics.stringWidth(valor.toString());
			g.drawString(valor.toString(), x+4, y+15);
			g.drawOval(x, y, adv+8, 20);
		}
	}
}

