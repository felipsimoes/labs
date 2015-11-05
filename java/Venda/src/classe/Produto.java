package classe;

public class Produto {
	private String descricao;
	private int codigo;
	
	public Produto(int c,String d){
		codigo=c;
		descricao=d;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	
}
