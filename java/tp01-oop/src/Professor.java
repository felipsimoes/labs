
public class Professor extends Pessoa {
	private double sal_hora;
	private int tot_horas;
	
	public Professor(String s, double h, int th){
		super(s);
		this.sal_hora = h;
		this.tot_horas = th;
	}
	
	public double getSal_hora() {
		return sal_hora;
	}
	public void setSal_hora(double sal_hora) {
		this.sal_hora = sal_hora;
	}
	public int getTot_horas() {
		return tot_horas;
	}
	public void setTot_horas(int tot_horas) {
		this.tot_horas = tot_horas;
	}
	
	public double getSalario(){
		return sal_hora * tot_horas * 4.5;
	}
}
