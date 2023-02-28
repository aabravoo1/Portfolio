//Proyecto de Medio Termino "Numerote"
//Agustin Salvador Quintanar de la Mora
//A01636142
//Andrés Antonio Bravo Orozco 
//A01630783

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;

public class Numerote {
	private byte[] numerote;
	private boolean signo;

	public Numerote(){
		this("0"); //Inicializa un numero en cero y con signo positivo
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
	public Numerote(String numerote) {
		if (numerote.charAt(0) == '-'){ //Comprobueba si es negativo y elimina el signo si es el caso
			numerote = numerote.replace("-", "");
			this.signo = false;
		} else {
			this.signo = true;
		}
		this.numerote = new byte[numerote.length()];
		for (int i = 0; i <this.numerote.length; i++){
			this.numerote[i] = Byte.parseByte(Character.toString(numerote.charAt(this.numerote.length-i-1)));
		}
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
	public Numerote suma(Numerote numeroteB) throws NumberFormatException{
		int carryOut = 0;
		byte[] numeroteMayor,
				numeroteMenor;

		String resultado = "",
				signoResultado = "";
	////////////////////////////////////////////////////////////////////////////////////////////////
		if(this.numerote.length >= numeroteB.numerote.length) { //Determina el numerote menor y mayor
			numeroteMayor = this.numerote;
			numeroteMenor = numeroteB.numerote;
		}
		else {
			numeroteMayor = numeroteB.numerote;
			numeroteMenor = this.numerote;
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		if(this.signo == numeroteB.signo) { //Determina si los numerotes poseen el mismo signo
			for (int i=0; i<numeroteMayor.length;i++) {
				try { //Si hay un 1 digito en los 2 sumandos realiza las siguientes operaciones
					resultado += (numeroteMayor[i] + numeroteMenor[i] + carryOut)%10;
					carryOut = (numeroteMayor[i] + numeroteMenor[i] + carryOut)/10;
			} catch (ArrayIndexOutOfBoundsException e) { //En caso de que no hubiera 1 digito en uno de los 2 sumandos seria catchado por esta excepcion
				resultado += (numeroteMayor[i] + carryOut)%10;
				carryOut = (numeroteMayor[i] + carryOut)/10;
				}
		}
			if(carryOut != 0) { //En caso de que hubiera carryOut al final de la suma, este se le agrega al resultado
				resultado += String.valueOf(carryOut);
			}
			resultado = new StringBuilder(resultado).reverse().toString(); //Invierte el string del resultado
			if(!this.signo) { //Como lo establece la condicion de arriba, los signos son iguales, por lo tanto si uno es negativo el resultado sera negativo
				signoResultado = "-";
			}
		}
		else { //En caso de que los signos fueran diferentes se manda a llamar al metodo resta
			if(!this.signo) { // Forma B-A
				return numeroteB.resta(new Numerote(this.toString())); //Cuando se convierte a string se elimina el signo negativo
			}
			else { //Forma A-B
				return this.resta(new Numerote(numeroteB.toString()));//Cuando se convierte a string se elimina el signo negativo
			}
		}
		return new Numerote(signoResultado + resultado);//Regresa un objeto de tipo numerote
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
	public Numerote resta(Numerote numeroteB) throws NumberFormatException{
		int carryOut = 0;
		String signoResultado = "",
				resultado = "";
		byte[] numeroteMayor = {0},
				numeroteMenor = {0};
//////////////////////////////////////////////////////////////////////////////////////////////////////
	  if(this.numerote.length > numeroteB.numerote.length) { //Determina el numero mayor y el menor
		  numeroteMayor = this.numerote;
		  numeroteMenor = numeroteB.numerote;
	  }
	  else if(this.numerote.length == numeroteB.numerote.length) { //Si son iguales checa digito por digito
		  for(int i=0; i<this.numerote.length; i++) {
			  if(this.numerote[this.numerote.length-1-i]>numeroteB.numerote[numeroteB.numerote.length-1-i] ) {
				  numeroteMayor = this.numerote;
				  numeroteMenor = numeroteB.numerote;
				  break;
			  } else if (this.numerote[this.numerote.length-1-i]<numeroteB.numerote[numeroteB.numerote.length-1-i] ) {
				  numeroteMayor = numeroteB.numerote;
				  numeroteMenor = this.numerote;
				  break;
			  }
		  }
	  }
	  else { 
		  numeroteMayor = numeroteB.numerote;
		  numeroteMenor = this.numerote;
	  }
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	  if((numeroteMayor == this.numerote && !this.signo) || (numeroteMayor == numeroteB.numerote && this.signo)) {
		  signoResultado = "-"; //Determina cuando la multiplicacion es negativa
	  }
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	  if(this.signo == numeroteB.signo) { //Operaciones que realiza cuando los signos de los numerotes son iguales
		  for (int i=0; i<numeroteMayor.length;i++) {
			  try {//Realiza estas operaciones en el caso que exista el bit de minuendo y sustraendo en la posicion actual
				  if(numeroteMayor[i] - numeroteMenor[i] - carryOut >= 0) { 
					  resultado += numeroteMayor[i] - numeroteMenor[i] - carryOut;
					  carryOut = 0;
				  }
				  else { 
					  resultado += 10 + numeroteMayor[i] - numeroteMenor[i] - carryOut;
					  carryOut = 1;
				  }
			} catch (ArrayIndexOutOfBoundsException e) {//En caso de que no existiera ningun bit en el sustraendo se realizarian estas operaciones
				if(carryOut != 0 && numeroteMayor[i]==0) {
					resultado += 10 + numeroteMayor[i] - carryOut;
					  carryOut = 1;
				}
				else {
					resultado += numeroteMayor[i] - carryOut;
					carryOut = 0;
				}
			}
		  }
		  resultado = new StringBuilder(resultado).reverse().toString(); //Invierte el resultado
		
		while(resultado.charAt(0)=='0' && resultado.length()>1) { //Elimina los ceros de sobra
			resultado = resultado.substring(1, resultado.length());
		}
	
	  }
	  else { //En caso de que los signos sean diferentes se manda llamar la suma
		  if(!this.signo) { // Forma -A-B
			  return this.suma(new Numerote("-"+numeroteB.toString()));
		  }
		  else { // Forma A-(-B) = A+B
			  return this.suma(new Numerote(numeroteB.toString()));
		  }
	  }
	 return new Numerote(signoResultado + resultado);
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public Numerote multiplica(Numerote numeroteB) throws NumberFormatException{
  int carryOut = 0;
	String renglon,
		   ceros = "";
	Numerote resultado = new Numerote();

	if(this.toString()=="0"||numeroteB.toString()=="0"){ //En  caso de que uno de los factores sea 0 regresa 0
		return resultado;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	for(int i=0; i<numeroteB.numerote.length; i++) { //Realiza las operaciones de la multiplicacion
		renglon = "";
		carryOut = 0;
		for(int j=0; j<this.numerote.length; j++) {
			renglon += (numeroteB.numerote[i]*this.numerote[j] + carryOut)%10;
			carryOut = (numeroteB.numerote[i]*this.numerote[j]+carryOut)/10;
		}

	renglon += String.valueOf(carryOut);
	resultado = resultado.suma(new Numerote(new StringBuilder(renglon).reverse().toString()+ceros));
	ceros += "0";
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	while(resultado.toString().charAt(0) == '0' && resultado.toString().length()>1) {
		resultado = new Numerote(resultado.toString().substring(1, resultado.toString().length()));
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	if(this.signo != numeroteB.signo) { //Determina el signo del resultado
		resultado.signo = false;
	}
	
	
	return resultado;
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public static void ejecutaArchivo(String entrada, String salida) {
	  try {
		  BufferedReader br = new BufferedReader(new FileReader(entrada));
		  PrintWriter pw = new PrintWriter(new FileWriter(salida));
		  String linea,
		  		 num1,
		  		 num2,
		  		 operacion,
		  		 resultado = "0";
		  Numerote numerote3;
		  while ((linea = br.readLine()) != null ) {
			  StringTokenizer st = new StringTokenizer(linea,",");
			  num1 = st.nextToken();
			  num2 = st.nextToken();
			  operacion = st.nextToken();

			  if (operacion.equals("s")) {
				  numerote3 = new Numerote(num1).suma(new Numerote(num2));
				  if (numerote3.signo) {
					  resultado = String.valueOf(numerote3);
				  } else {
					  resultado = "-" + String.valueOf(numerote3);
				  }

			  } else if (operacion.equals("r")) {
				  numerote3 = new Numerote(num1).resta(new Numerote(num2));
				  if (numerote3.signo) {
					  resultado = String.valueOf(numerote3);
				  } else {
					  resultado = "-" + String.valueOf(numerote3);
				  }
			  } else if (operacion.equals("m")) {
				  numerote3 = new Numerote(num1).multiplica(new Numerote(num2));
				  if (numerote3.signo) {
					  resultado = String.valueOf(numerote3);
				  } else {
					  resultado = "-" + String.valueOf(numerote3);
				  }
			  }
			  pw.println(resultado);
		  }
		  br.close();
		  pw.close();
		  System.out.println("Se ejecuto el archivo exitosamente");

	  }catch(FileNotFoundException e) {
		  JOptionPane.showMessageDialog(null, "No se encuentra el archivo" );
	  }catch(IOException e) {
		  JOptionPane.showMessageDialog(null, "No se puede abrir el archivo" );
	  }catch(NumberFormatException e) {
		  JOptionPane.showMessageDialog(null, "El archivo contiene signos no reconocidos como numeros " );
	  }
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public String toString(){
    String numero = "";
    for (int i = 0; i <this.numerote.length; i++){
      numero += this.numerote[this.numerote.length-1-i];
    }
    return numero;
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public boolean getSigno() {
	  return this.signo;
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public byte[] getnumerote() {
	  return this.numerote;
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
}


