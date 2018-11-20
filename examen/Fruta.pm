package Fruta;
use strict;
use Venta;
use DBI;
use Data::Dumper;
my $dbh = DBI->connect("DBI:mysql:stock", "celeste", "teamo");


sub new{

	my $self = shift;	
	my $nombre_fruta = shift;
	my ($id , $precio, $cantidad )= obtener_fruta($nombre_fruta);	
	my $this = {
		id => $id,
		nombre_fruta => $nombre_fruta,
		precio => $precio,
		cantidad => $cantidad,
	};
	#print Dumper($id ,$precio , $cantidad);

	return bless ($this, $self);
}


sub salida_frutas{
    my $self = shift;    
    my $cantidad = $self -> cantidad();
    my $nombre_fruta = $self -> nombre_fruta();
    my $vendido = shift;
    my $total = $cantidad - $vendido;
    my $sql = "UPDATE frutas SET  cantidad = $total WHERE nombre_fruta = '$nombre_fruta' ";
	my $sth = $dbh->prepare($sql);
	$sth->execute();

	return $self->{cantidad};    
}


sub obtener_fruta{
	my $nombre_fruta = shift;    
    my $sql = "SELECT id, precio, cantidad From frutas WHERE nombre_fruta = '$nombre_fruta'";
	my $sth = $dbh->prepare($sql);
	$sth -> execute();
	my $row = $sth->fetchrow_hashref;
	return ($row->{id},$row->{precio},$row->{cantidad}); 	


}

sub nombre_fruta{
	my $self = shift;
	my $nombre_fruta= shift;
	if ($nombre_fruta) {
		$self->{nombre_fruta} = $nombre_fruta;
	}
	return $self->{nombre_fruta};
}


sub precio{
	my $self = shift;
	my $precio = shift;
	if ($precio) {
		$self->{precio} = $precio;
	}
	return $self->{precio};
}


sub cantidad{
	my $self = shift;
	my $cantidad= shift;
	if ($cantidad) {
		$self->{cantidad} = $cantidad;
	}
	return $self->{cantidad};
}


sub id{
	my $self = shift;
	my $id= shift;
	if ($id) {
		$self->{id} = $id;
	}
	return $self->{id};
}


sub mostrar_stock{

	my @stock = ();  

	my $sth = $dbh->prepare("SELECT nombre_fruta FROM frutas");

	$sth -> execute();

	while (my $row = $sth->fetchrow_hashref) {

	   my $frutas = Fruta ->new($row->{nombre_fruta});

		push (@stock,$frutas);

		
	}
	
	return @stock;
	
}


1;