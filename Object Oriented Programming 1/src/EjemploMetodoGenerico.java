
public class EjemploMetodoGenerico {
	
	
	
	public static <E>E imprimeArreglo(E[] numeros) { /////porque static?
		for (int i = 0; i < numeros.length; i++) {
			System.out.print(numeros[i]+" ");
		}
		System.out.println();
		return numeros[0];
	}
	
	public static void main(String[] args) {
		Integer[] numeros = {10,20,30,40,50,60,43};
		Double[] decimales = {12.3,4234.3,434.5,6.4};
		String[] palabra= {"hola","gggj","perro"};
		Caja[] caja = {new Caja(), new Caja(1,2,3)};
		int res1 = imprimeArreglo(numeros);
		double res2= imprimeArreglo(decimales);
		String res3= imprimeArreglo(palabra);
		Caja res4 = imprimeArreglo(caja);
	}
}
