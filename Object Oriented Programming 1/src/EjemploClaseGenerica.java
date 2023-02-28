
public class EjemploClaseGenerica <E extends Comparable<E>>{
	
	private E[] arreglo;
	public EjemploClaseGenerica(E[] arreglo) {
		this.arreglo = arreglo;
	}
	
	public E min() {
		E menor = this.arreglo[0];
		for(int i = 0; i < arreglo.length; i++) {
			if (menor.compareTo(this.arreglo[i]) > 0) { //porque se puede hacer la ocmparacion, que criterios? 
				menor = this.arreglo[i];
			}
		}
		return menor;
	}
	
	
	public static void main(String[] args) {
		Integer[] numeros = {10,20,30,40,50,60,43};
		Double[] decimales = {12.3,4234.3,434.5,6.4};
		String[] palabra= {"hola","gggj","perro", "Andres"};
		
		EjemploClaseGenerica<Integer> ecg1 = new EjemploClaseGenerica(numeros);
		EjemploClaseGenerica<String> ecg2 = new EjemploClaseGenerica(palabra);
		
		System.out.println(ecg1.min());
		System.out.println(ecg2.min());
		
	}
}
