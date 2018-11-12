#!/urs/bin/perl
use lib '/home/celeste/fujoshi';
use strict;
use Data::Dumper;
use User;
use DBI;

my $user_name;
my $first_name;
my $last_name;
my $age;
my $email;
my $password;
my $active = 1;
my $id;


 
my $dbh = DBI->connect("DBI:mysql:111k", "celeste", "teamo");


#my $user = User new($user_name, $first_name, $last_name,$age,$email,$passwod);
	
my $opcion = 1;
 
while ($opcion != 0){
	print "\n"."Buenos dias" ."\n";
	print "\n";

	print "Si desea agragar un usuario elija la opcion 1"."\n";
	print "\n";

	print "Si desea modifica un usuario elija opcion 2" . "\n";
	print "\n";

	print "Si desea eleminar un usuario elija la opcion 3" ."\n";
	print "\n";

	print "Si desea listas los usuarios eleja del opcion 4" . "\n";
	print "\n";

	print "Si desea salir ingrese 0" . "\n";
	print "\n";
	
	$opcion = <STDIN>;
	chomp($opcion);
	
	
if ($opcion == 1){
	
		print "Ingrese sus datos" . "\n";
		print "\n";
		add_user();			 
			
		}
if($opcion == 2) {
			
		print "Ingrese los datos del usuario a modificar" ."\n";
		print "\n";
		modify_user();




		}
if ($opcion == 3){
			
		print "Ingrese el nombre de usuario a madificar" . "\n";
		print "\n";
		delete_user();

					}
if ($opcion == 4){
			
		print "Siguien se listara los usuarion" . "\n";
		print "\n";
		lista();
		}
if ($opcion == 0){
			
		print "Saliendo del sistema" . "\n";
		print "\n";
		exit;
		}
}


sub add_user{	
	
	print "Ingrese nombre de Nick" . "\n";
    $user_name = <STDIN>;
	chomp($user_name);
	print "-----------\n";

	print "Ingrese el prime nombre" . "\n";  
    $first_name = <STDIN>;
    chomp($first_name);
    print "-----------\n";

    print "Ingrese el apellido" . "\n";
    $last_name =<STDIN>;
    chomp($last_name);
    print "-----------\n";

    print "Ingrese edad" . "\n";
    $age = <STDIN>;
    chomp($age);
    print "-----------\n";

    print "Ingrse el mail" . "\n";
    $email = <STDIN>;
    chomp($email);
    print "-----------\n";

    print "Ingrese contraseña" . "\n"; 
    $password = <STDIN>;
    chomp($password);
    print "-----------\n";

   my $user = User -> new($user_name,$first_name,$last_name,$age,$email,$password);
   $user ->crear_user();
   
   } 

sub modify_user{

 
    print "Ingrse en nick del usuario a modificar\n";
	$user_name = <STDIN>;
	chomp($user_name);
	print "\n";
	my $user = User::find_user($user_name);

	if ($user->get_user_name()){		 

	print "Reingrese el prime nombre\n" ;  
    $first_name = <STDIN>;
    chomp($first_name);
    print "-----------\n";

    print "Reingrese el apellido" . "\n";
    $last_name =<STDIN>;
    chomp($last_name);
    print "-----------\n";

    print "Reingrese edad" . "\n";
    $age = <STDIN>;
    chomp($age); 
    print "-----------\n";   

    print "Reingresecontraseña" . "\n"; 
    $password = <STDIN>;
    chomp($password);
    print "-----------\n";

	 }    
     
    $user ->modify_first_name($first_name);
    $user ->modify_last_name($last_name);
    $user ->modify_age($age);
    $user ->modify_password($password);

   
}

sub delete_user{

	print "¿ Que usuario desea eliminar ? Ingrese el nick". "\n";
	my $user_name =<STDIN>;
	chomp($user_name);
	print "\n";

	my $user = User::find_user($user_name);

	if ($user->get_user_name()){

		print "Borrando usuarion " . " * " . $user_name. " * " . " Es tarde para arrenpetimintos\n";

		$user -> delete_user();
	}
	

}

sub lista{
	
     my @users = User::list_user();
     
       	foreach my $lista (@users) {
     	print  $lista->get_user_name() ."\n";     	
     	print  $lista->get_first_name() ."\n";
     	print  $lista->get_last_name() ."\n";
     	print  $lista->get_age() ."\n";
     	print  $lista->email() ."\n";
     	print "######################\n";

     	}
     
     }
     
    	
               
      



1;

