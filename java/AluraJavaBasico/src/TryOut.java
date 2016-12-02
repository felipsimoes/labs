
public class TryOut {

	public static void main(String[] args) {
		String t;
		t = String.format("%3$d %<d %d %04d", 100, 200, 300);
		System.out.println(t);
	}

}
