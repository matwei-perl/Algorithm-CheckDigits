package Algorithm::CheckDigits::M10_002;

use 5.006;
use strict;
use warnings;
use integer;

our $VERSION = '0.53';

our @ISA = qw(Algorithm::CheckDigits);

sub new {
	my $proto = shift;
	my $type  = shift;
	my $class = ref($proto) || $proto;
	my $self  = bless({}, $class);
	$self->{type} = lc($type);
	return $self;
} # new()

sub is_valid {
	my ($self,$number) = @_;
	if ($number =~ /^([0-9 ]*)([0-9])$/) {
		return $2 == $self->_compute_checkdigit($1);
	}
	return ''
} # is_valid()

sub complete {
	my ($self,$number) = @_;
	if ($number =~ /^[0-9 ]*$/) {
		return  $number . $self->_compute_checkdigit($number);
	}
	return '';
} # complete()

sub basenumber {
	my ($self,$number) = @_;
	if ($number =~ /^([0-9 ]*)([0-9])$/) {
		return $1 if ($2 == $self->_compute_checkdigit($1));
	}
	return '';
} # basenumber()

sub checkdigit {
	my ($self,$number) = @_;
	if ($number =~ /^([0-9 ]*)([0-9])$/) {
		return $2 if ($2 == $self->_compute_checkdigit($1));
	}
	return '';
} # checkdigit()

sub _compute_checkdigit {
	my $self   = shift;
	my $number = shift;
	$number =~ s/\s//g;
	if ($number =~ /^([0-9]*)$/) {
		my @digits = split(//,$number);
		my $even = 1;
		my $sum  = 0;
		for (my $i = $#digits; $i >= 0; $i--) {
			if ($even) {
				my $tmp = 2 * $digits[$i];
				$sum += $tmp / 10 + $tmp % 10;
			} else {
				$sum += $digits[$i];
			}
			$even = not $even;
		}
		return (10 - $sum % 10) % 10;
	}
	return -1;
} # _compute_checkdigit()

# Preloaded methods go here.

1;
__END__

=head1 NAME

CheckDigits::M10_002 - compute check digits for CINS (US), SIREN (FR),
SIRET (FR)

=head1 SYNOPSIS

  use Algorithm::CheckDigits;

  $siret = CheckDigits('siret');

  if ($siret->is_valid('73282932000074')) {
	# do something
  }

  $cn = $siret->complete('7328293200007');
  # $cn = '73282932000074'

  $cd = $siret->checkdigit('73282932000074');
  # $cd = '4'

  $bn = $siret->basenumber('73282932000074');
  # $bn = '7328293200007'
  
=head1 DESCRIPTION

=head2 ALGORITHM

=over 4

=item 1

Beginning right all numbers are weighted alternatively 1 and 2.

=item 2

The total of the digits of all products is computed.

=item 3

The sum of step 3 ist taken modulo 10.

=item 4

The check digit is the difference between 10 and the number from step
3 taken modulo 10.

=back

=head2 METHODS

=over 4

=item is_valid($number)

Returns true only if C<$number> consists solely of numbers and the last digit
is a valid check digit according to the algorithm given above.

Returns false otherwise,

=item complete($number)

The check digit for C<$number> is computed and concatenated to the end
of C<$number>.

Returns the complete number with check digit or '' if C<$number>
does not consist solely of digits and spaces.

=item basenumber($number)

Returns the basenumber of C<$number> if C<$number> has a valid check
digit.

Return '' otherwise.

=item checkdigit($number)

Returns the checkdigit of C<$number> if C<$number> has a valid check
digit.

Return '' otherwise.

=back

=head2 EXPORT

None by default.

=head1 AUTHOR

Mathias Weidner, C<< <mamawe@cpan.org> >>

=head1 SEE ALSO

L<perl>,
L<CheckDigits>,
F<www.pruefziffernberechnung.de>.
F<www.dsi.cnrs.fr/bureau_qualite/admindonnees/documents/siren.pdf>

=cut
