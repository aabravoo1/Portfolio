import java.io.*;
import java.util.StringTokenizer;

public class CalculaNomina {
	public static void main(String[] args) {
		try {
			BufferedReader br = new BufferedReader(new FileReader("horasTrabajadas.txt"));
			PrintWriter pw = new PrintWriter(new FileWriter("nomina.txt"));
			String linea,
				   nombre,
				   paterno;
			int hrs;
			double tabulador;
			StringTokenizer st;
			br.readLine();
			linea = br.readLine();
			
			pw.println("Nombre Completo,Pago");
			while (linea != null) {
				st = new StringTokenizer(linea);
				nombre = st.nextToken();
				paterno = st.nextToken();
				hrs = Integer.parseInt(st.nextToken());
				tabulador = Double.parseDouble(st.nextToken());
				pw.println(nombre+ "," + paterno + "," + hrs*tabulador);
				linea = br.readLine();
			}
			br.close();
			pw.close();
			System.out.println("FIN");
		
		} catch(FileNotFoundException ex) {
			
		}catch(IOException ex) {
			
		}
	}
}
