package classe;

public class Cliente {
	private String CNPJ;
	private String razao;
	private static int contador=0;
	private int codigo=0;
	
	public Cliente(String c, String r){
		CNPJ=c;
		razao=r;
		codigo=++contador;
	}

	public String getCNPJ() {
		return CNPJ;
	}

	public void setCNPJ(String cNPJ) {
		CNPJ = cNPJ;
	}

	public String getRazao() {
		return razao;
	}

	public void setRazao(String razao) {
		this.razao = razao;
	}

	public int getContador() {
		return contador;
	}

	public void setContador(int contador) {
		this.contador = contador;
	}

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	
}
