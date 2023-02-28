import java.io.PrintWriter;
import java.io.FileWriter;
import java.io.IOException;

public class EjemploEscritor {

	public static void main(String[] args) {
		try {
			FileWriter fw = new FileWriter("nuevo.txt");
			PrintWriter pw = new PrintWriter(fw);
			pw.println("Este es mi primer archivo de texto creado desde Java");
			pw.println("Espero que funcione correctamente");
			pw.println("Fin");
			pw.close();
			
			
		} catch (IOException ex) {
			System.out.println("No se puede abrir el archivo");
		}
	}

}
