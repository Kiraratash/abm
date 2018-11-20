package Venta;
use strict;
use DBI;
use Data::Dumper;
use Fruta;
my $dbh = DBI->connect("DBI:mysql:stock", "celeste", "teamo");

sub new{
	my $self =shift;
	my $cantidad = shift;
	my $nombre_fruta = shift;
	my $id_fruta = shift;
	my $venta =  shift;
    #insertar_venta($fruta, $cantidad,$venta , $id_fruta);
	my $this = {		
		cantidad => $cantidad,
		id_fruta => $id_fruta,	
		nombre_fruta => $nombre_fruta,		
		venta => $venta,

		
	};
	return bless ($this, $self);
}


sub guardar_venta{
	my $self = shift;		
	my $sql= "INSERT  INTO ventas (fruta , cantidad_vendida, ventas , id_frutas)  VALUES (?,?,?,?)";
	my $sth = $dbh->prepare($sql);
	  $sth->execute($self->{nombre_fruta}, $self->{cantidad}, $self->{venta}, $self->{id_fruta});

}



sub obtener_ventas{	

	my @ventas = ();

	my $sth = $dbh->prepare("SELECT fruta , cantidad_vendida , id_frutas, ventas FROM ventas");

	$sth -> execute();

	while (my $row = $sth->fetchrow_hashref) {

	   my $venta = Venta->new( $row->{cantidad_vendida}, $row->{fruta} ,$row->{id_frutas},$row->{ventas});

		
		push (@ventas,$venta);
		
	} 
	
	return @ventas;	

}

sub beneficio_total{	
	my $sql = "SELECT SUM(ventas) FROM ventas";
	my $sth = $dbh -> prepare($sql);
	 $sth->execute();
	 my $row = $sth ->fetchrow_hashref; 
	 
	return  $row ->{"SUM(ventas)"};

}

sub nombre_fruta{
	my $self = shift;
	my $nombre_fruta= shift;
	if ($nombre_fruta) {
		$self->{nombre_fruta} = $nombre_fruta;
	}
	return $self->{nombre_fruta};
}

sub cantidad {
	my $self = shift;
	my $cantidad = shift;
	if ($cantidad) {
		$self->{cantidad} = $cantidad;
	}
	return $self->{cantidad};
}

sub id_fruta{
	my $self = shift;
	my $id_fruta = shift;
	if ($id_fruta){
		$self->{id_fruta} = $id_fruta;
	}
	return $self->{id_fruta};
}

sub venta{
	my $self = shift;
	my $venta = shift;
	if ($venta) {
		$self->{venta} = $venta;
	}
	return $self->{venta};
}
sub  precio {
    my $self = shift;
    my $precio = shift;
    if ($precio) {
    	$self->{precio} = $precio;
  }
    return $self->{precio};

    }

1;