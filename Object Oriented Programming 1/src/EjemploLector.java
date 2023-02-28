import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.IOException;

public class EjemploLector {

	public static void main(String[] args) {
		try {
			BufferedReader br = new BufferedReader(new FileReader("nuevo.txt"));
			System.out.println(br.readLine());//regresa la linea que sigue en leerse si no hay nada mas que leer regresa null
			
			String linea;
			while ((linea = br.readLine()) != null) {
				System.out.println(linea);
			}
			br.close();

		} catch (FileNotFoundException e) {
			System.out.println("No se localizó el archivo "+ e);
			
		} catch (IOException ex) {
			System.out.println("Ocurrio un error de I/O" + ex);
		}
	}

}
