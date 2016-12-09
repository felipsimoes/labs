package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

import bd.ConexaoBD;
import servlets.Imovel;

public class DAO {

	private static final String TABLE_IMOVEL = "imovel";
	public DAO() { 	}

	public void inserirImovel(Imovel imovel) throws SQLException{
		Connection con = (Connection) ConexaoBD.getConexao();
		int i = 1;
		String sql = "INSERT INTO "+TABLE_IMOVEL+" (endereco, quartos, metros, valor) VALUES ( ?, ?, ?, ? )";
		PreparedStatement prepareStatement = con.prepareStatement(sql);
		prepareStatement.setString(i++, imovel.getEndereco());
		prepareStatement.setInt(i++, imovel.getNumQuartos());
		prepareStatement.setInt(i++, imovel.getMetrosQuadrados());
		prepareStatement.setDouble(i++, imovel.getValorLocacao());

		prepareStatement.execute();
		con.close();
	}

	public boolean alterarImovel(Imovel imovel) throws SQLException{
		Connection con = (Connection) ConexaoBD.getConexao();
		int i = 1;
		String sql = "UPDATE "+TABLE_IMOVEL+" SET "
				+ " endereco = ?, quartos = ?, metros = ?, valor = ? "
				+ " WHERE cd = ? ";
		PreparedStatement prepareStatement = con.prepareStatement(sql);
		prepareStatement.setString(i++, imovel.getEndereco());
		prepareStatement.setInt(i++, imovel.getNumQuartos());
		prepareStatement.setInt(i++, imovel.getMetrosQuadrados());
		prepareStatement.setDouble(i++, imovel.getValorLocacao());
		prepareStatement.setInt(i++, imovel.getCd());

		boolean b = prepareStatement.execute();
		con.close();
		return b;
	}

	public Imovel getImovelPorId(Imovel im) throws SQLException{
		Connection con  = (Connection)ConexaoBD.getConexao();
		String sql = "SELECT * FROM imovel "
				+ "WHERE cd = ?";	
		PreparedStatement p = con.prepareStatement(sql);
		p.setInt(1, im.getCd());
		ResultSet result = p.executeQuery();
		Imovel imovel = null;
		while(result.next()){
			imovel = new Imovel();
			imovel.setEndereco(result.getString("endereco"));
			imovel.setMetrosQuadrados(result.getInt("metros"));
			imovel.setNumQuartos(result.getInt("quartos"));
			imovel.setValorLocacao(result.getInt("valor"));
			imovel.setCd(result.getInt("cd"));
		}
		con.close();
		return imovel;
	}

	public boolean excluirImovel(Imovel imovel) throws SQLException {
		Connection con = (Connection) ConexaoBD.getConexao();
		int i = 1;
		String sql = "DELETE FROM "+TABLE_IMOVEL+
				" WHERE cd = ? ";
		PreparedStatement prepareStatement = con.prepareStatement(sql);
		prepareStatement.setInt(i++, imovel.getCd());

		int b = prepareStatement.executeUpdate();
		con.close();
		boolean r = (b >= 1) ? true : false ;
		return r;
	}


}
