package br.com.casadocodigo.livraria.produtos;

// The interface produto inherits the other Interface Comparable
// therefore it uses extends instead of implements
// The comparable interface uses generics as well
public interface Produto extends Comparable<Produto> {
	
	double getValor();
}
