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

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JColorChooser;
import javax.swing.JFileChooser;
import javax.swing.JPanel;
import javax.swing.JRadioButton;



public class EstudiarControles extends JPanel implements ActionListener, MouseListener{
	private JButton btnGuardar,
					btnAbrir;
	private JPanel jp; 
	private EstudiarPanel ep;
	private JRadioButton btnRojo,
						 btnAzul,
						 btnVerde;
	
	public EstudiarControles(EstudiarPanel ep) {
		super();
		this.setPreferredSize(new Dimension(100,400));
		this.ep = ep;
		
		this.btnGuardar = new JButton("Guardar");
		this.btnGuardar.addActionListener(this);
		
		this.btnAbrir = new JButton("Abrir");
		this.btnAbrir.addActionListener(this);
	
		this.jp = new JPanel();
		this.jp.setBackground(Color.RED);
		this.jp.setPreferredSize(new Dimension(90,90));
		this.jp.addMouseListener(this);
		
		this.btnRojo = new JRadioButton("Rojo");
		this.btnRojo.addActionListener(this);
		this.btnVerde = new JRadioButton("Verde");
		this.btnVerde.addActionListener(this);
		this.btnAzul = new JRadioButton("Azul");
		this.btnAzul.addActionListener(this);
		ButtonGroup btnG = new ButtonGroup();
		btnG.add(this.btnAzul);
		
		
		
		this.add(btnGuardar);
		this.add(btnAbrir);
		this.add(jp);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		if(e.getSource() == btnGuardar) {
			JFileChooser jfc = new JFileChooser();
			int opcion = jfc.showSaveDialog(this.ep);
			if (opcion == JFileChooser.APPROVE_OPTION) {
				File file = jfc.getSelectedFile();
				try {
					PrintWriter pw = new PrintWriter(file.getAbsolutePath());
					pw.println(this.ep.getColorOvalo().getRGB());
					pw.println(this.ep.getXO());
					pw.println(this.ep.getYO());
					pw.close();
					
				} catch(IOException ex) {
					System.out.println("oopsie");
				}
			}
		} else if (e.getSource() == this.btnAbrir) {
			JFileChooser jfc = new JFileChooser();
			int opcion = jfc.showOpenDialog(this.ep);
			if (opcion == JFileChooser.APPROVE_OPTION) {
				File file = jfc.getSelectedFile();
				try {
					BufferedReader br = new BufferedReader(new FileReader(file.getAbsolutePath()));
					this.ep.setColorOvalo(new Color(Integer.parseInt(br.readLine())));
					this.ep.setX(Integer.parseInt(br.readLine()));
					this.ep.setY(Integer.parseInt(br.readLine()));
					br.close();
				} catch (IOException ex) {
					System.out.println("oopsie2");
				}
			}
		}
		
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		// TODO Auto-generated method stub
		Color color = JColorChooser.showDialog(this, "Escoge un color", Color.red);
		
		this.jp.setBackground(color);
		this.ep.setColorOvalo(color);
		
		
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
