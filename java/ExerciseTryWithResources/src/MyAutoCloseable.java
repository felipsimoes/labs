import java.io.IOException;

public class MyAutoCloseable implements AutoCloseable{
	public void saySomething() {
		System.out.println("Something");
	}
	
	@Override
	public void close() throws IOException {
		System.out.println("close");
	}
}
