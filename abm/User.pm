package User;
use strict;
use DBI;
use Data::Dumper;

my $dbh = DBI->connect("DBI:mysql:111k", "celeste", "teamo");

sub new{
	my $self = shift;
	my $user_name = shift;
	my $first_name = shift;
    my $last_name = shift;
    my $age = shift;
    my $email = shift;
    my $password = shift;
    my $active = shift;
    my $this = {
		user_name => $user_name,
		password => $password,
		first_name => $first_name,
		last_name => $last_name,
		age => $age,
		email => $email,
		active => 1,

	};

	return bless ($this,$self);
}

# crea un user 
sub crear_user{
	my $self = shift;
	my $user_name = $self-> {user_name};	
	my $first_name = $self-> {first_name};
    my $last_name = $self-> {last_name};
    my $age = $self-> {age};
    my $email = $self-> {email};
    my $password = $self-> {password};
    my $active = $self->{active};

    

	my $sth = $dbh->prepare("insert into user ( user_name, first_name, last_name, age, email, password, active) values ( ? , ? , ?, ? , ? ,?,?)");
         $sth ->execute( $user_name,  $first_name,  $last_name, $age, $email , $password ,$active);
}


# modificadores de los datos de user 

sub modify_first_name{
    my $self = shift;
    my $first_name = shift;
    my $user_name = $self->{user_name};
    my $sql = "UPDATE user SET first_name = '$first_name' WHERE user_name = '$user_name'";
	my $sth = $dbh->prepare($sql);
	$sth->execute();

	return $self->{first_name};    
}
sub modify_last_name{
    my $self = shift;
    my $last_name = shift;
    my $user_name = $self->{user_name};
    my $sql = "UPDATE user SET last_name = '$last_name' WHERE user_name = '$user_name'";
	my $sth = $dbh->prepare($sql);
	$sth->execute();

	return $self->{last_name};    
}
sub modify_age{
    my $self = shift;
    my $age = shift;
    my $user_name = $self->{user_name};
    my $sql = "UPDATE user SET age = '$age' WHERE user_name = '$user_name'";
	my $sth = $dbh->prepare($sql);
	$sth->execute();

	return $self->{age};    
}
sub modify_password{
    my $self = shift;
    my $password = shift;
    my $user_name = $self->{user_name};
    my $sql = "UPDATE user SET password = '$password' WHERE user_name = '$user_name'";
	my $sth = $dbh->prepare($sql);
	$sth->execute();

	return $self->{password};    
}

# genera una intaciacia de user , como no hay sobrecarga de contructores genere este metodo
sub find_user{
	my $user_name = shift;    
    my $sql = "SELECT * FROM user WHERE user_name = '$user_name'";
	my $sth = $dbh->prepare($sql);
	$sth -> execute();
	my $row = $sth->fetchrow_hashref;
	my $user = User -> new($row->{user_name},$row->{first_name},$row->{last_name},$row->{age},$row->{email},$row->{password},$row->{active}); 
	return $user;
	
}

# borra un usuarion atraver de user name

sub delete_user{
	my $self = shift;	
	my $user_name = $self->{user_name};
	my $sql = "DELETE FROM user WHERE user_name = '$user_name'";
	my $sth = $dbh->prepare($sql);
	$sth->execute();

}


# Listado de usuarios
sub list_user{
	my @users = ();  

	my $sth = $dbh->prepare(" SELECT * FROM user");

	$sth -> execute();

	while (my $row = $sth->fetchrow_hashref) {

	   my $user = User -> new($row->{user_name},$row->{first_name},$row->{last_name},$row->{age},$row->{email},$row->{password},$row->{active});

		push (@users,$user);
		
	}
	
	return @users;


}


# Geter and Seters
sub set_first_name{
	my $self = shift;
	my $firt_name = shift;
	$self->{firt_name} = $firt_name;
}


sub set_last_name{
	my $self = shift;
	my $last_name = shift;
	$self->{last_name} = $last_name;	 
}

sub set_age{
	my $self = shift;
	my $age = shift;
	$self->{age} = $age;
}

sub email{
	my $self = shift;
	my $email = shift;
	if ($email){
	    $self->{email} = $email;	
	}
	return $self->{email}
	
}

sub set_active{
	my $self = shift;
	my $active = shift;
	$self -> {active} = $active;
}


sub get_user_name{
	my $self = shift;
	return $self -> {user_name};
}


sub get_password {
    my $self = shift;
	return $self -> {password};
}

sub get_first_name {
    my $self = shift;
	return $self -> {first_name};
}
sub get_last_name {
    my $self = shift;
	return $self -> {last_name};
}
sub get_age {
    my $self = shift;
	return $self -> {age};
}

sub get_active {
    my $self = 1;
	return $self -> {active};
}


1;



