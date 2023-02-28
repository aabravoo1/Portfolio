//Si ocurre alguna exception volverá a pedir  tdos los datos, pero indicando cual fue el error
import javax.swing.JOptionPane;
public class Division {
	public static int divisionEntera(int num, int den) {
		return num/den;
	}
	public static int tryout() {
		int c = 0;
		try {
			int n = Integer.parseInt(JOptionPane.showInputDialog("Escribe un numero"));
			int d = Integer.parseInt(JOptionPane.showInputDialog("Escribe otro numero"));
			int res = divisionEntera(n,d);
			JOptionPane.showMessageDialog(null, "El resultado de la division entera de " + n + "/" + d + " es " + res );
			c = 1;
			return c;
		}
		catch (NumberFormatException e){
			System.out.println("NumberFormat exception: ingresaste algo diferente a un número entero , intenta de nuevo");
			return c;
		}
		catch (ArithmeticException e) {
			System.out.println("ArithmeticException, intenta de nuevo");
			return c;
		}
	}
	public static void main(String[] args) {
		int c = 0;
		while (c != 1) {
			c = tryout();
		}
	}
}
