public class Coordenador extends Professor {
	private int tot_alunos;

	public Coordenador(String n, double s, int t, int tot_alunos){
		super(n,s,t);
		this.tot_alunos = tot_alunos;
	}
	
	public int getTot_alunos() {
		return tot_alunos;
	}

	public void setTot_alunos(int tot_alunos) {
		this.tot_alunos = tot_alunos;
	}

	public double getSalario(){
		if(this.getTot_alunos() < 500){
			return super.getSalario() * 1.1;
		}
		else if((this.getTot_alunos() >= 500) && (this.getTot_alunos() < 1000)){
			return super.getSalario() * 1.15;
		}
		else {
			return super.getSalario() * 1.2;
		}
	}
}
