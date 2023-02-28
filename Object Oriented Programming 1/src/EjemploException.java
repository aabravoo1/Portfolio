
public class EjemploException {
	public void metodoA() throws Exception {
		this.metodoB();
	}
	
	public void metodoB() throws Exception {
		this.metodoC();
	}
	
	public void metodoC() throws Exception {
		this.metodoD();
	}
	
	public void metodoD() throws Exception{ // se específica "throws" porque es una excepcion de tipo check
		throw new Exception("Ocurrió un error metodo D");
	}
	
	public static void main(String[] args) {
		EjemploException ee = new EjemploException();
		try {
			ee.metodoA(); //Se arroja el error a los metodos anteriores que se mandaron llamar: el D llama al C, el C llama al B, el B llama al A y el A llama al main
		}
		catch(Exception e) {
			System.out.println("Error "+ e);
		}
		
	}
}
