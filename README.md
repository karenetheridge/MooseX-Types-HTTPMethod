# NAME

MooseX::Types::HTTPMethod - Type constraints for HTTP method names

# VERSION

version 0.001

# SYNOPSIS

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

# DESCRIPTION

This module implements string types which validate against all
HTTP method names currently defined by RFCs.  Multiple types are available,
encompassing various specifications:

- HTTPMethod10

    HTTP methods defined by HTTP 1.0: GET, POST, HEAD

- HTTPMethod11

    HTTP methods defined by HTTP 1.1: HTTP 1.0 plus OPTIONS, PUT, DELETE, TRACE
    and CONNECT

- HTTPMethod

    All HTTP methods currently defined by RFCs (HTTP 1.1 plus a whole lot more,
    mostly for WebDAV protocols)

# IMPORTED FUNCTIONS

As with all [MooseX::Types](http://search.cpan.org/perldoc?MooseX::Types) types, the inclusion of one type name `'Foo'`
in the `use` line will result in an import of these functions:

- `Foo`

    returns the type itself (an object implementing the
    [Moose::Meta::TypeConstraint](http://search.cpan.org/perldoc?Moose::Meta::TypeConstraint) interface), and

- `is_Foo`

    a function returning a bool, checking if the passed value validates against
    the `Foo` type

# SUPPORT

Bugs may be submitted through [https://rt.cpan.org/Public/Dist/Display.html?Name=MooseX-Types-HTTPMethod](https://rt.cpan.org/Public/Dist/Display.html?Name=MooseX-Types-HTTPMethod).
I am also usually active on irc, as 'ether' at [irc://irc.perl.org](irc://irc.perl.org).

# SEE ALSO

[RFC 1945: HTTP 1.0](http://www.w3.org/Protocols/rfc1945/rfc1945)

[RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html)

[HTTP Extensions for Distributed Authoring -- WebDAV](http://tools.ietf.org/html/rfc2518)

[Versioning Extensions to WebDAV (Web Distributed Authoring and Versioning)](http://tools.ietf.org/html/rfc3253)

[Web Distributed Authoring and Versioning (WebDAV) Ordered Collections Protocol](http://tools.ietf.org/html/rfc3648)

[Web Distributed Authoring and Versioning (WebDAV) Access Control Protocol](http://tools.ietf.org/html/rfc3744)

[PATCH Method for HTTP](https://tools.ietf.org/html/rfc5789)

# AUTHOR

Karen Etheridge <ether@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Karen Etheridge.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
