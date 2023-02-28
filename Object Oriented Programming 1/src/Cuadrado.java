
public class Cuadrado extends Rectangulo{
	public Cuadrado(double lado) {
		super(lado,lado); //Manda llamar al constructor de la clase rectangulo 
	}
	public Cuadrado() {
		this(5.0);
	}
	
	public String toString() {
		return "El cuadrado tiene un lado de: " + this.ancho; 
	}
}
