
public class Rectangulo implements Figura{ //como la clase implementa una interface, tiene que contener todos los metodos declarados en la interface 
	protected double largo,
    ancho;

	public Rectangulo(double largo, double ancho){
		this.largo = largo;
		this.ancho = ancho;
	} 

	public Rectangulo(){
		this(5.0,2.0);
	}

	public double perimetro(){
		return 2.0*this.largo + 2.0*this.ancho;
	}
		
	public double area(){
		return this.largo*this.ancho;
	}
	
	public double volumen() {
		return 0.0;
	}
	
	public String toString() {
		return "El Rectangulo tiene un largo de:" + this.largo + " y el ancho es: " + this.ancho;
	}
	
	public static void main(String[] args){
		Figura[] figuras = {new Rectangulo(6.0,4.0), new Cuadrado(6.0), new Caja(10.0,15.3,20.0) };
		for (int i = 0; i < figuras.length; i++) {
			System.out.println(figuras[i]); //Imprime cada figura con sus respectivos valores 
			System.out.println("El perimetro es: " + figuras[i].perimetro());
			System.out.println("El area es: " + figuras[i].area());
			System.out.println("El volumen es: " +figuras[i].volumen());
			System.out.println();
			//no se puede llamar unn metodo que no este en la clase Figura; necesita tener todos los metodos de esta interface y no puede agregar otros
			if (figuras[i] instanceof Caja) { //instanceof pregunta si un objeto es instancia de una clase en particular, en este caso pregunta si el objeto en la posicion i es una caja o hija de caja
				Caja tmp = (Caja)figuras[i]; //se hace un casting para ver si la figura[i] es una caja
				tmp.saluda();
				//((Caja)figuras[i]).saluda(); 
			}
		}
		
		
		
	}
}

