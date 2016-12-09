package bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoBD {

	public static String status = "Não conectou...";

	public ConexaoBD() {    }

	public static java.sql.Connection getConexao(){

		Connection connection = null;       
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String serverName = "localhost:3306";    
			String mydatabase = "tp2";        
			String url = "jdbc:mysql://" + serverName + "/" + mydatabase;
			String username = "root";       
			String password = "";   
			connection = (Connection) DriverManager.getConnection(url, username, password);
			if (connection != null) {
				status = ("STATUS--->Conectado com sucesso!");
			} else {
				status = ("STATUS--->Não foi possivel realizar conexão");
			}

			return connection;

		} catch (SQLException | InstantiationException | IllegalAccessException | ClassNotFoundException e) {
			System.out.println("Nao foi possivel conectar ao Banco de Dados.");
			System.out.println(e.getMessage());
			return null;
		}

	}

	public static String statusConection() {
		return status; 
	}

	public static boolean FecharConexao() throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		try {
			ConexaoBD.getConexao().close();
			return true;

		} catch (SQLException e) {
			return false;
		}
	}

	public static java.sql.Connection ReiniciarConexao() throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		FecharConexao();
		return ConexaoBD.getConexao();
	}

}
