/*ControlesEspiral.java
 * Andrés Antonio Bravo Orozco
 * A0163783
 * Comentarios: esta tarea me sirvió mucho para poder comprender los conceptos vistos en clase
 */
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.JTextField;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

public class ControlesEspiral extends JPanel implements ActionListener, ChangeListener{
	private PanelEspiral pe = new PanelEspiral();
	private JTextField tfNumero,
						tfRepeticiones;
	private JButton btnNumero,
					btnAnimacionStart,
					btnAnimacionStop; 
	private JSlider slider;
	private JLabel labelLados,
					labelRepeticiones;
	private boolean animacion;
	
	public ControlesEspiral(PanelEspiral pe) {
		super();
		this.pe = pe;
		this.setPreferredSize(new Dimension(100,400));
		this.animacion = false;
		
		this.tfNumero = new JTextField(6);
		this.tfRepeticiones = new JTextField(6);
		
		this.btnNumero = new JButton("Aplicar");
		this.btnNumero.addActionListener(this);
		
		this.slider = new JSlider(JSlider.VERTICAL, 0, 20, 5);
		this.slider.setMajorTickSpacing(2);
		this.slider.setPaintTicks(true);
		this.slider.setPaintLabels(true);
		this.slider.addChangeListener(this);
		
		this.labelLados = new JLabel("Numero de lados");
		this.labelRepeticiones = new JLabel("Repeticiones");
		
		this.btnAnimacionStart = new JButton("Start");
		this.btnAnimacionStart.addActionListener(this);
		
		this.btnAnimacionStop = new JButton("Stop");
		this.btnAnimacionStop.addActionListener(this);
		
		this.add(this.labelLados);
		this.add(this.tfNumero);
		this.add(this.labelRepeticiones);
		this.add(this.tfRepeticiones);
		this.add(this.btnNumero);
		this.add(this.slider);
		this.add(this.btnAnimacionStart);
		this.add(this.btnAnimacionStop);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == this.btnNumero) {
			if(this.tfNumero.getText() == "") {
				this.pe.setN(4);
			}if(this.tfRepeticiones.getText() == "") {
				this.pe.setReps(100);
			}else {
				this.pe.setN(Integer.parseInt(this.tfNumero.getText()));
				this.pe.setReps(Integer.parseInt(this.tfRepeticiones.getText()));
			}
		} else if (e.getSource() == this.btnAnimacionStart) {
			this.pe.setAnimacion(true);
		} else if (e.getSource() == this.btnAnimacionStop) {
			this.pe.setAnimacion(false);
		}
		
		
	}

	@Override
	public void stateChanged(ChangeEvent e) {
		// TODO Auto-generated method stub
		this.pe.setRadio(this.slider.getValue());
	}

}
