use strict;
use warnings;

package My::List;

{ package Iterator;
  sub new {
      my $class = shift;
      my $self = { List => shift };
      bless $self, $class;
  }
  sub has_next {
      my $self = shift;
      my $list = $self->{List};
      ${$list}->{Next};
  }
  sub next {
      my $self = shift;
      my $list = $self->{List};
      $self->{List} = ${$list}->{Next};
      $self->{List};
  }
}

sub new {
    my $class = shift;
    my $self = { Value => undef, Next => undef };
    bless \$self, $class;
}

sub iterator {
    my $self = shift;
    Iterator->new($self);
}


sub append {
    my $self = shift;
    my $new = My::List->new;
    ${$new}->{Value} = shift;
    
    while (${$self}->{Next}) {
	$self = ${$self}->{Next};
    }
    
    ${$self}->{Next} = $new;
}

sub value {
    my $self = shift;
    ${$self}->{Value};
}


1;
