#!/usr/bin/perl
use lib '/home/celeste/fujoshi/examen';
use strict;
use DBI;
use Data::Dumper;
use Fruta;
use Venta;

my $nombre_fruta ;
my $cantidad ;


#vista_stock();

my $corte = 1;
while ($corte !=0) {

   print "Ingrse nombre de la fruta vendida\n"; 
	$nombre_fruta = <STDIN>;
	chomp($nombre_fruta);
	print "\n";

	my $fruta = Fruta->new($nombre_fruta);
    #print Dumper($fruta);

	if ($fruta->nombre_fruta()){		 

	print "Cantidad vendida \n";
    $cantidad = <STDIN>;
    chomp($cantidad);
    
    print "-----------\n";

    my $venta = Venta -> new($cantidad, $nombre_fruta, $fruta->id(),($fruta->precio()* $cantidad));

    $fruta->salida_frutas($cantidad);
    $venta->guardar_venta();
    vista_ventas();
    #print Dumper(Venta->beneficio_total());
    print "Beneficions totales \n" . Venta->beneficio_total() . "\n";

    print Dumper(salida_ventas());
    
    print "si desea seguir digita 1 si dece cortar digite 0\n";
    $corte =<STDIN>;
    chomp($corte);


 


}  

} 


sub salida_ventas {
    my %cantidad_vendida;
    my @ventas = Venta::obtener_ventas;
    foreach my $venta (@ventas){       
       my $nombre = $venta->nombre_fruta();
       if ($cantidad_vendida {$nombre}) {
        my $cantidad = $venta->cantidad();
        my $cantidad_inicial = $cantidad_vendida {$nombre};
        $cantidad_vendida {$nombre} = $cantidad + $cantidad_inicial;    


        }else{
            $cantidad_vendida {$nombre} = $venta->cantidad();
        }      

    }

    return %cantidad_vendida;

}

sub vista_stock{
	
    my @frutas = Fruta::mostrar_stock();


    foreach my $muestra (@frutas) {
     	print   $muestra->nombre_fruta() ."\n"; 
     	print "Precion es  \n";    	
     	print   $muestra->precio () ."\n";
     	print "La cantidad en stock es \n";
     	print   $muestra->cantidad() ."\n";
     	
     	print "######################\n";

     	}
}



sub vista_ventas{
    
    my @ventas = Venta::obtener_ventas;
    foreach my $muestra (@ventas) {
        print   $muestra->nombre_fruta() ."\n";        
        print "La cantidad vendida \n";
        print   $muestra->cantidad() ."\n";
        
        print "######################\n";



        }

}


1;



