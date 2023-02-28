
public class Caja extends Rectangulo{
	protected double altura;
	
	public Caja(double largo, double ancho, double altura) {
		super(largo, ancho);
		this.altura = altura;
	}
	
	public Caja() {
		this(5.0,5.0,5.0);
	}
	
	public double perimetro() {
		return 8.0*this.altura + 4.0*this.largo + 2.0*this.ancho;
	}
	
	public double area() {
		return 2.0*(this.ancho*this.largo+ this.largo*this.altura+this.altura*this.ancho);
	}
	
	public double volumen() {
		return super.area()*this.altura;
	}
	
	public String toString() {
		return "La caja tiene un largo de: " + this.largo + " una altura de: " + this.altura + " y un ancho de: " + this.ancho;
	}
	
	public String saluda() {
		return "Soy una caja feliz :D";
	}
}

