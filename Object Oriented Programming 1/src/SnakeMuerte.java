import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class SnakeMuerte extends JPanel implements ActionListener{
	private JButton btnRevivir;
	private JLabel jlTexto;
	
	public SnakeMuerte() {
		super();
		this.setPreferredSize(new Dimension(800,400));
		this.setLayout(null);
		this.setBackground(Color.DARK_GRAY);
		
		this.jlTexto = new JLabel("Quieres jugar de nuevo?");
		this.jlTexto.setForeground(Color.WHITE);
		this.jlTexto.setSize(200, 200);
		this.jlTexto.setBounds(300, 0, 200, 200);
		
		
		this.btnRevivir = new JButton("Revivir");
		this.btnRevivir.setBounds(300, 180, 30, 20);
		this.btnRevivir.addActionListener(this);
		
		this.add(this.jlTexto);
		this.add(this.btnRevivir);
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		
	}
	
}
