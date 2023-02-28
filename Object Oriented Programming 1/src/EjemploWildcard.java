import java.util.ArrayList;

public class EjemploWildcard {
	
	public static double suma(ArrayList<? extends Number> numeros) {
		double c = 0.0;
		
		for (int i= 0; i< numeros.size() ; i++) {
			c += numeros.get(i).doubleValue();
		}
		return c; 
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ArrayList<Number> numeros = new ArrayList<>();
		for(int i = 0; i<20 ;i++) {
			numeros.add(i);
		}
		
		System.out.println(suma(numeros));
		
		ArrayList<Integer> numeros2 = new ArrayList<>();
		for(int i = 0; i<20 ;i++) {
			numeros2.add(i);
		}
		
		System.out.println(suma(numeros2));
	}

}
