//Proyecto de Medio Termino "Numerote"
//Agustin Salvador Quintanar de la Mora
//A01636142
//Andrés Antonio Bravo Orozco 
//A01630783

import java.awt.Color;
import java.awt.Desktop;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;

public class NumeroteControles extends JPanel implements ActionListener{
	private JTextField tfNum1,
					   tfNum2,
					   tfResultado;
	private JRadioButton suma,
						 resta,
						 multiplicacion;
	private JButton btnCalcular,
					btnArchivoEntrada,
					btnArchivoSalida,
					btnCreaArchivo;
	private Numerote numerote1,
					 numerote2,
					 numerote3;
	private String archivoEntrada = "",
				   archivoSalida = "salida.txt";
	private JLabel num1,
				   num2,
				   resultado,
				   espacio1,
				   op;

	public NumeroteControles() {
		super();
		this.setPreferredSize(new Dimension(620,300));

		this.num1 = new JLabel("Numero 1");
		this.num2 = new JLabel("Numero 2");
		this.resultado = new JLabel("Resultado");
		this.espacio1 = new JLabel("                                    ");
		this.op = new JLabel("Operacion a realizar:");

		this.tfNum1 = new JTextField(60);
		this.tfNum2 = new JTextField(60);
		this.tfResultado = new JTextField(60);


		this.suma = new JRadioButton("Suma");
		this.resta = new JRadioButton("Resta");
		this.multiplicacion = new JRadioButton("Multiplicacion");
		ButtonGroup bg = new ButtonGroup();
		bg.add(this.suma);
		bg.add(this.resta);
		bg.add(this.multiplicacion);

		this.btnCalcular = new JButton("Calcular");
		this.btnCalcular.addActionListener(this);

		this.btnArchivoEntrada = new JButton("Selecciona un archivo de entrada");
		this.btnArchivoEntrada.addActionListener(this);

		this.btnArchivoSalida = new JButton("Selecciona un archivo de salida");
		this.btnArchivoSalida.addActionListener(this);

		this.btnCreaArchivo = new JButton("Crear archivo");
		this.btnCreaArchivo.addActionListener(this);


		this.add(this.num1);
		this.add(this.tfNum1);
		this.add(this.num2);
		this.add(this.tfNum2);
		
		this.add(this.espacio1);
		this.add(this.op);
		this.add(this.suma);
		this.add(this.resta);
		this.add(this.multiplicacion);

		
		this.add(this.btnCalcular);
		
		this.add(this.espacio1);
		this.add(this.resultado);
		this.add(this.tfResultado);
		this.add(this.btnArchivoEntrada);
		this.add(this.btnArchivoSalida);
		this.add(this.btnCreaArchivo);
	}


	@Override
	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == this.btnCalcular) {
			if(this.suma.isSelected()) {
				try {
					this.numerote1 = new Numerote(this.tfNum1.getText());
					this.numerote2 = new Numerote(this.tfNum2.getText());
					this.numerote3 = numerote1.suma(numerote2);
					  if (this.numerote3.getSigno()) {
						  this.tfResultado.setText(String.valueOf(this.numerote3));
					  } else {
						  this.tfResultado.setText("-" + String.valueOf(this.numerote3));
					  }
				} catch (NumberFormatException ex) {
					JOptionPane.showMessageDialog(null, ex + " El archivo contiene getSigno()s no reconocidos como numeros " );
				} catch (StringIndexOutOfBoundsException ex) {
					JOptionPane.showMessageDialog(null, ex + " Ingresa un numero en ambos campos" );
				}

			} else if(this.resta.isSelected()) {
				try {
					this.numerote1 = new Numerote(this.tfNum1.getText());
					this.numerote2 = new Numerote(this.tfNum2.getText());
					this.numerote3 = numerote1.resta(numerote2);
					  if (this.numerote3.getSigno()) {
						  this.tfResultado.setText(String.valueOf(this.numerote3));
					  } else {
						  this.tfResultado.setText("-" + String.valueOf(this.numerote3));
					  }
				}catch (NumberFormatException ex) {
					JOptionPane.showMessageDialog(null, " El archivo contiene signos no reconocidos como numeros " );
				} catch (StringIndexOutOfBoundsException ex) {
					JOptionPane.showMessageDialog(null, "Ingresa un numero en ambos campos" );
				}

			} else if(this.multiplicacion.isSelected()) {
				try {
					this.numerote1 = new Numerote(this.tfNum1.getText());
					this.numerote2 = new Numerote(this.tfNum2.getText());
					this.numerote3 = numerote1.multiplica(numerote2);
					  if (this.numerote3.getSigno()) {
						  this.tfResultado.setText(String.valueOf(this.numerote3));
					  } else {
						  this.tfResultado.setText("-" + String.valueOf(this.numerote3));
					  }
				}catch (NumberFormatException ex) {
					JOptionPane.showMessageDialog(null,  " El archivo contiene getSigno()s no reconocidos como numeros " );
				} catch (StringIndexOutOfBoundsException ex) {
					JOptionPane.showMessageDialog(null, " Ingresa un numero en ambos campos" );
				}
			}else {
				JOptionPane.showMessageDialog(null, "Seleciona una operacion" );
			}

		} else if (e.getSource() == this.btnArchivoEntrada) {
			JFileChooser fc = new JFileChooser();
			int respArchivo = fc.showOpenDialog(this);
			if(respArchivo == JFileChooser.APPROVE_OPTION) {
				File archivo = fc.getSelectedFile();
				this.archivoEntrada = archivo.getAbsolutePath();
			}

		} else if(e.getSource() == this.btnArchivoSalida) {
			JFileChooser fc = new JFileChooser();
			int respArchivo = fc.showSaveDialog(this);
			if(respArchivo == JFileChooser.APPROVE_OPTION) {
				File archivo = fc.getSelectedFile();
				this.archivoSalida = archivo.getAbsolutePath();
			}
		} else if(e.getSource() == this.btnCreaArchivo) {
			if (this.archivoEntrada.equals("")) {
				JOptionPane.showMessageDialog(null, "Seleciona un archivo de entrada" );
			} else {
				Numerote.ejecutaArchivo( this.archivoEntrada, this.archivoSalida);
			}
		}
	}

}
