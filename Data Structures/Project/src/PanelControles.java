
/**
 * Proyecto Final de Estructuras de Datos
 * Panel de Controles para Arbol AVL
 * Esta clase crea y programa los controles necesarios para utilizar la simulacion de Arbol AVL.
 * @author Andres Antonio Bravo Orozco A01630783
 * @author Jean Carlo Alvarez Guerra A01635182
 * PanelControles.java
 */

import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.BorderFactory;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.border.Border;

public class PanelControles extends JPanel{
	private JButton      btnAplicar;
	private JRadioButton rbInsertar,
						 rbEliminar,
						 rbEliminarArbol;
	private JTextField   tfDato;
	private JMenuBar     menu, 
						 menuRecorrido;
	private JMenu        tipoDeDato, 
						 tipoDeRecorrido;
	private JMenuItem    MIInteger,
					     MIString,
					     MIDouble,
					     MIPreorden,
					     MIInorden,
					     MIPostorden;
	private JLabel       tipoSeleccionado;
	private Border       raisedbevel,
				         loweredbevel,
				         compound;
	private Panel        p;
	
	/**
	 * Constructor de PanelControles.
	 * Inicializa las caracteristicas del panel, crea, agrega y 
	 * programa todos sus elementos y las acciones que deben realizar.
	 * @param p el panel donde se va a agregar.
	 */
	public PanelControles(Panel p) {
		super();
		this.p = p;
		
		this.setPreferredSize(new Dimension(1300,42));
		this.raisedbevel = BorderFactory.createRaisedBevelBorder();
		this.loweredbevel = BorderFactory.createLoweredBevelBorder();
		compound = BorderFactory.createCompoundBorder(raisedbevel, loweredbevel);
		this.setBorder(this.compound);
		this.setBackground(Color.white);
		
		this.rbInsertar = new JRadioButton("Insertar dato");
		this.rbEliminar = new JRadioButton("Elminiar dato");
		this.rbEliminarArbol = new JRadioButton("Elminiar árbol");
		
		ButtonGroup bg = new ButtonGroup();
		bg.add(this.rbInsertar);
		bg.add(this.rbEliminar);
		bg.add(this.rbEliminarArbol);
		
		this.tfDato = new JTextField(10);
		
		
		this.btnAplicar = new JButton("Aplicar");
		this.btnAplicar.addActionListener(new ActionListener() {

			@Override
			/**
			 * Action Listener para boton aplicar.
			 * Determina la accion a realizar dependiendo de las opciones seleccionadas. Insertar, eliminar dato o eliminar el arbol. 
			 * @throws NumberFormatException si el dato ingresado es diferente al tipo de dato del arbol seleccionado. 
			 */
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				try {
					if(p.getSel() == 0) {
						if(rbInsertar.isSelected()) {
							p.insertInteger(Integer.parseInt(tfDato.getText()));
						}else if(rbEliminar.isSelected()) {
							p.removeInteger(Integer.parseInt(tfDato.getText()));
						}else if(rbEliminarArbol.isSelected()){
							p.flushInteger();
						}else {
							
						}
					}else if(p.getSel() == 1) {
						if(rbInsertar.isSelected()) {
							p.insertString(tfDato.getText());
						}else if(rbEliminar.isSelected()) {
							p.removeString(tfDato.getText());
						}else if(rbEliminarArbol.isSelected()){
							p.flushString();
						}else {
							
						}
					}else {
						if(rbInsertar.isSelected()) {
							p.insertDouble(Double.parseDouble(tfDato.getText()));
						}else if(rbEliminar.isSelected()){
							p.removeDouble(Double.parseDouble(tfDato.getText()));
						}else if(rbEliminarArbol.isSelected()){
							p.flushDouble();
						}else {
							
						}
					}
				} catch (NumberFormatException e1) {
					throw new NumberFormatException("No se puede insertar o eliminar datos de tipo diferente al seleccionado");
				}
			}
		});
		
		this.menu       = new JMenuBar();
		this.tipoDeDato = new JMenu("Tipo de Dato: ");
		this.MIInteger  = new JMenuItem("Integer");
		this.MIString   = new JMenuItem("String");
		this.MIDouble   = new JMenuItem("Double");
		
		this.menu.add(this.tipoDeDato);
		this.tipoDeDato.add(this.MIInteger);
		this.tipoDeDato.add(this.MIString);
		this.tipoDeDato.add(this.MIDouble);
		
		this.MIInteger.addActionListener(new ActionListener(){
			
			/**
			 * Action listener del menu item Integer.
			 * Cambia a trabajar y pintar solamente con el arbol de Integer.
			 */
			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				p.setSel(0);
				tipoSeleccionado.setText("Integer");
				p.repaint();
			}
		});
		
		this.MIString.addActionListener(new ActionListener(){
			@Override
			/**
			 * Action listener del menu item String.
			 * Cambia a trabajar y pintar solamente con el arbol de String.
			 */
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				p.setSel(1);
				tipoSeleccionado.setText("String");
				p.repaint();
			}
		});
		
		this.MIDouble.addActionListener(new ActionListener(){
			@Override
			/**
			 * Action listener del menu item Double.
			 * Cambia a trabajar y pintar solamente con el arbol de Double.
			 */
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				p.setSel(2);
				tipoSeleccionado.setText("Double");
				p.repaint();
			}
		});
		
		this.tipoSeleccionado = new JLabel("Integer");
		
		this.menuRecorrido   = new JMenuBar();
		this.tipoDeRecorrido = new JMenu("Imprimir en: ");
		this.MIPreorden      = new JMenuItem("Preorden");
		this.MIInorden       = new JMenuItem("Inorden");
		this.MIPostorden     = new JMenuItem("Postorden");
		
		this.menuRecorrido.add(this.tipoDeRecorrido);
		this.tipoDeRecorrido.add(this.MIPreorden);
		this.tipoDeRecorrido.add(this.MIInorden);
		this.tipoDeRecorrido.add(this.MIPostorden);
		
		this.MIPreorden.addActionListener(new ActionListener(){
			@Override
			/**
			 * Action listener del menu item Preorden.
			 * Cambia el tipo de recorrido a realizar y repinta el panel. 
			 */
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				p.setTipo(0);
				p.repaint();
				//p.setTipo(3);
			}
		});
		
		this.MIInorden.addActionListener(new ActionListener(){
			@Override
			/**
			 * Action listener del menu item Inorden.
			 * Cambia el tipo de recorrido a realizar y repinta el panel. 
			 */
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				p.setTipo(1);
				p.repaint();
				//p.setTipo(3);
			}
		});
		
		this.MIPostorden.addActionListener(new ActionListener(){
			@Override
			/**
			 * Action listener del menu item Postorden.
			 * Cambia el tipo de recorrido a realizar y repinta el panel. 
			 */
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				p.setTipo(2);
				p.repaint();
				//p.setTipo(3);
			}
		});
		
		
		
		this.add(this.rbInsertar);
		this.add(this.rbEliminar);
		this.add(this.rbEliminarArbol);
		this.add(this.tfDato);
		this.add(this.btnAplicar);
		this.add(this.menu);
		this.add(this.tipoSeleccionado);
		this.add(this.menuRecorrido);
		
		
	}
}
