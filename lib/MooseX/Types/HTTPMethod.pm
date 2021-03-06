use strict;
use warnings;
package MooseX::Types::HTTPMethod;
# vim: set ts=8 sts=4 sw=4 tw=115 et :
# ABSTRACT: Type constraints for HTTP method names
# KEYWORDS: moose type constraint HTTP method methods RFC

our $VERSION = '0.003';

use MooseX::Types -declare => [ qw(HTTPMethod10 HTTPMethod11 HTTPMethod) ];
use MooseX::Types::Moose 'Str';
use if MooseX::Types->VERSION >= 0.42, 'namespace::autoclean';

my @http10_methods = qw(GET POST HEAD);                     # RFC 1945
my @http11_methods = (
    @http10_methods,
    qw(OPTIONS PUT DELETE TRACE CONNECT),                   # RFC 2616
);

my @methods = (
    @http11_methods,
    qw(PROPFIND PROPPATCH MKCOL COPY MOVE LOCK UNLOCK),     # RFC 2518
    qw(VERSION-CONTROL REPORT CHECKOUT CHECKIN UNCHECKOUT MKWORKSPACE
        UPDATE LABEL MERGE BASELINE-CONTROL MKACTIVITY),    # RFC 3253
    qw(ORDERPATCH),                                         # RFC 3648
    qw(ACL),                                                # RFC 3744
    qw(PATCH),                                              # RFC 5789
);

my %http10_methods; @http10_methods{@http10_methods} = () x @http10_methods;
subtype HTTPMethod10,
    #as Stringlike,
    as Str,
    where { exists $http10_methods{$_} };

my %http11_methods; @http11_methods{@http11_methods} = () x @http11_methods;
subtype HTTPMethod11,
    #as Stringlike,
    as Str,
    where { exists $http11_methods{$_} };

my %methods; @methods{@methods} = () x @methods;
subtype HTTPMethod,
    #as Stringlike,
    as Str,
    where { exists $methods{$_} };

1;
__END__

=pod

=head1 SYNOPSIS

    use Moose;
    use MooseX::Type::HTTPMethod qw(HTTPMethod11 HTTPMethod);

    has rest_query_type => (
        is => 'ro', isa => HTTPMethod11,
    );

    has request_type => (
        is => 'ro', isa => HTTPMethod,
    );

    print "GET is an HTTP/1.1 method: ", (is_HTTPMethod11('GET') : 1 : 0), "\n";
    # prints 1
    print "PATCH is an HTTP/1.1 method: ", (is_HTTPMethod11('FOO') : 1 : 0), "\n";
    # prints 0

    print "GET is an HTTP method: ", (is_HTTPMethod('GET') : 1 : 0), "\n";
    # prints 1
    print "PATCH is an HTTP method: ", (is_HTTPMethod('PATCH') : 1 : 0), "\n";
    # prints 1

=head1 DESCRIPTION

This module implements string types which validate against all
HTTP method names currently defined by RFCs.

=head1 TYPES

Multiple types are available, encompassing various specifications:

=type C<HTTPMethod10>

HTTP methods defined by HTTP 1.0: GET, POST, HEAD

=type C<HTTPMethod11>

HTTP methods defined by HTTP 1.1: HTTP 1.0 plus OPTIONS, PUT, DELETE, TRACE
and CONNECT

=type C<HTTPMethod>

=for stopwords WebDAV

All HTTP methods currently defined by RFCs (HTTP 1.1 plus a whole lot more,
mostly for WebDAV protocols)

=head1 IMPORTED FUNCTIONS

As with all L<MooseX::Types> types, the inclusion of one type name C<'Foo'>
in the C<use> line will result in an import of these functions:

=head2 C<Foo>

returns the type itself (an object implementing the
L<Moose::Meta::TypeConstraint> interface), and

=head2 C<is_Foo>

a function returning a bool, checking if the passed value validates against
the C<Foo> type

=head1 SEE ALSO

=for stopwords WebDAV Versioning

=for :list
* L<RFC 1945: HTTP 1.0|http://www.w3.org/Protocols/rfc1945/rfc1945>
* L<RFC 2616|http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html>
* L<HTTP Extensions for Distributed Authoring -- WebDAV|http://tools.ietf.org/html/rfc2518>
* L<Versioning Extensions to WebDAV (Web Distributed Authoring and Versioning)|http://tools.ietf.org/html/rfc3253>
* L<Web Distributed Authoring and Versioning (WebDAV) Ordered Collections Protocol|http://tools.ietf.org/html/rfc3648>
* L<Web Distributed Authoring and Versioning (WebDAV) Access Control Protocol|http://tools.ietf.org/html/rfc3744>
* L<PATCH Method for HTTP|https://tools.ietf.org/html/rfc5789>

=cut
