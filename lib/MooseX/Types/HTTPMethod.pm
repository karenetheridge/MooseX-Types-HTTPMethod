use strict;
use warnings;
package MooseX::Types::HTTPMethod;

use MooseX::Types -declare => [ qw(HTTPMethod10 HTTPMethod11 HTTPMethod) ];
use MooseX::Types::Moose 'Str';
use MooseX::Types::Stringlike qw(Stringlike Stringable);

my @http10_methods = qw(GET POST HEAD);                     # RFC 1945
my @http11_methods = qw(OPTIONS PUT DELETE TRACE CONNECT);  # RFC 2616

my @methods = (
    @http11_methods,
    qw(PROPFIND PROPPATCH MKCOL COPY MOVE LOCK UNLOCK), # RFC 2518
    qw(VERSION-CONTROL REPORT CHECKOUT CHECKIN UNCHECKOUT MKWORKSPACE UPDATE
        LABEL MERGE BASELINE-CONTROL MKACTIVITY),       # RFC 3253
    qw(ORDERPATCH),                                     # RFC 3648
    qw(ACL),                                            # RFC 3744
    qw(PATCH),                                          # RFC 5789
);

my %http10_methods; @http10_methods{@http10_methods} = () x @http10_methods;
subtype HTTPMethod10,
    as Stringlike,
#as Str,
    where { exists $http10_methods{$_} };

my %http11_methods = %http10_methods; @http11_methods{@http11_methods} = () x @http11_methods;
subtype HTTPMethod11,
#as Str,
    as Stringlike,
    where { exists $http11_methods{$_} };

my %methods = %http11_methods; @methods{@methods} = () x @methods;
subtype HTTPMethod,
#as Str,
    as Stringlike,
    where { exists $methods{$_} };

1;
__END__

=pod

=head1 SYNOPSIS

...

=head1 METHODS

=over

=item * C<foo>

=back

...

=head1 SUPPORT

Bugs may be submitted through L<https://rt.cpan.org/Public/Dist/Display.html?Name= >.
I am also usually active on irc, as 'ether' at L<irc://irc.perl.org>.

=head1 ACKNOWLEDGEMENTS

...

=head1 SEE ALSO

...

=cut
