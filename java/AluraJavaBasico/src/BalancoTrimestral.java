
public class BalancoTrimestral {
	public static void main(String[] args) {
		int gastosJaneiro = 15000;
		int gastosFeveiro = 23000; 
		int gastosMarco = 17000;
		int gastosTrimestre = gastosJaneiro + gastosFeveiro + gastosMarco;
		int mediaMensal = gastosTrimestre / 3;
		
		System.out.println(gastosTrimestre);
		System.out.println("Valor da m�dia mensal = "+mediaMensal);
		int v = 150;
		while (v <= 300) {
			System.out.println(v);
			++v;
		}
		
		int soma = 0;
		for (int i = 1; i <= 1000; i++) {
			soma+= i;
			System.out.println(soma);
		}
	}
}