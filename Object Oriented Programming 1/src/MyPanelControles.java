import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JColorChooser;
import javax.swing.JFileChooser;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JSlider;
import javax.swing.JTextField;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

public class MyPanelControles extends JPanel implements ChangeListener, MouseListener{
	private JTextField tfNombre; //lugar para inggresar datos a la ventana
	private JButton btNombre,
					btnColor,
					btnGuardar,
					btnAbrir; //buton 
	private JRadioButton rbRojo,
						rbAzul,
						rbVerde;
	private MyPanelDibujo pd;
	private JPanel panelColor;
	private JSlider slider;
	
	
	public MyPanelControles(MyPanelDibujo pd) {
		super();
		this.pd = pd;
		
		this.setPreferredSize(new Dimension (150,600));
		this.tfNombre = new JTextField(10);
		this.btNombre = new JButton("Saluda");//texto dentro del botton 
		this.btNombre.addActionListener(new ActionListener() { //clase anónima

			public void actionPerformed(ActionEvent e) {
				pd.setNombre(tfNombre.getText());
			}
			
		});//hace referencia a la clase actionperformed 
		
		this.rbRojo = new JRadioButton("Color Rojo", true); //en un nombre mas largo caben menos en la fila
		this.rbVerde = new JRadioButton("Color Verde");
		this.rbAzul = new JRadioButton("Color Azul");
		ButtonGroup bg = new ButtonGroup();
		bg.add(this.rbRojo);
		bg.add(this.rbVerde);
		bg.add(this.rbAzul);
		
		this.btnColor = new JButton("Cambiar color");
		this.btnColor.addActionListener(new ActionListener() {

			public void actionPerformed(ActionEvent e) {
				if(rbRojo.isSelected()){
					rbRojo.setBackground(Color.RED);
					setBackground(Color.RED);
				} 
				else if(rbVerde.isSelected()){
					rbVerde.setBackground(Color.GREEN);
					setBackground(Color.GREEN);
				}
				else {
					rbAzul.setBackground(Color.BLUE);
					setBackground(Color.BLUE);
				}
				
			}
			
		});
		
		this.add(this.tfNombre);
		this.add(this.btNombre);
		this.add(this.rbAzul);
		this.add(this.rbRojo);
		this.add(this.rbVerde);
		this.add(this.btnColor);
		
		this.panelColor = new JPanel();
		this.panelColor.setPreferredSize (new Dimension(100, 100));
		this.panelColor.setBackground(Color.RED);
		this.panelColor.addMouseListener(this);
		this.add(this.panelColor);
		
		this.slider = new JSlider(JSlider.VERTICAL, 0, 200, 0);
		this.slider.setMajorTickSpacing(50);
		this.slider.setMinorTickSpacing(10);
		this.slider.setPaintTicks(true);
		this.slider.setPaintLabels(true);
		this.slider.addChangeListener(this);
		this.add(this.slider);
		
		this.btnAbrir = new JButton("Abrir Archivo");
		this.btnAbrir.addActionListener(new ActionListener() {
			int pd; // crea ambiguiedad con el elmento pd 
			public void actionPerformed(ActionEvent e) {
				JFileChooser fc = new JFileChooser();
				int respArchivo = fc.showOpenDialog(MyPanelControles.this.pd); //se puede utilizar "pd" si no hay una variable dentro de la calse anonima 
				if(respArchivo == JFileChooser.APPROVE_OPTION) {
					File archivo = fc.getSelectedFile();
					try {
						BufferedReader br = new BufferedReader(new FileReader(archivo.getAbsolutePath()));
						tfNombre.setText(br.readLine());
						MyPanelControles.this.pd.setxV(Integer.parseInt(br.readLine()));
						MyPanelControles.this.pd.setyV(Integer.parseInt(br.readLine()));
						setBackground(new Color(Integer.parseInt(br.readLine())));
						br.close();
					}catch(IOException ex) {
						
					}
				}
			}
			
		});
		this.add(this.btnAbrir);
		this.btnGuardar = new JButton("Guardar Archivo");
		this.btnGuardar.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				JFileChooser fc = new JFileChooser();
				int respArchivo = fc.showSaveDialog(pd);
				if (respArchivo == JFileChooser.APPROVE_OPTION) {
					File archivo = fc.getSelectedFile();
					try {
						PrintWriter pw = new PrintWriter(archivo.getAbsolutePath());
						pw.println(tfNombre.getText());
						pw.println(pd.getxV());
						pw.println(pd.getyV());
						pw.println(getBackground().getRGB());
						pw.close();
					}catch(IOException ex) {
						
					}
				}
			}
			
		});
		this.add(this.btnGuardar);
		
	}

	
	public static void main(String[] args) {
		

	}

	@Override
	public void stateChanged(ChangeEvent e) {
		System.out.println(this.slider.getValue());
		this.pd.setyV(-this.slider.getValue());
		
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		Random ran = new Random();
		Color color = JColorChooser.showDialog(this.pd, "Escoge el color del globo", this.panelColor.getBackground());
		
		this.pd.setColorGlobo(color);
		this.panelColor.setBackground(color);
		
	}

	@Override
	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub
		
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
