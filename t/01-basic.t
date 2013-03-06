use strict;
use warnings FATAL => 'all';

use Test::More tests => 22;
use Test::NoWarnings 1.04 ':early';

use MooseX::Types::HTTPMethod qw(HTTPMethod10 HTTPMethod11 HTTPMethod);

# type, value, valid?
my @constraints = (
    [ HTTPMethod,    '',        0 ],
    [ HTTPMethod,    0,         0 ],
    [ HTTPMethod,    undef,     0 ],
    [ HTTPMethod,    "\n",      0 ],

    [ HTTPMethod10,  'GET',     1 ],
    [ HTTPMethod10,  'HEAD',    1 ],
    [ HTTPMethod10,  'POST',    1 ],
    [ HTTPMethod10,  'PUT',     0 ],
    [ HTTPMethod10,  'DELETE',  0 ],
    [ HTTPMethod10,  'PATCH',   0 ],

    [ HTTPMethod11,  'GET',     1 ],
    [ HTTPMethod11,  'HEAD',    1 ],
    [ HTTPMethod11,  'POST',    1 ],
    [ HTTPMethod11,  'PUT',     1 ],
    [ HTTPMethod11,  'DELETE',  1 ],
    [ HTTPMethod11,  'OPTIONS', 1 ],
    [ HTTPMethod11,  'TRACE',   1 ],
    [ HTTPMethod11,  'CONNECT', 1 ],
    [ HTTPMethod11,  'PATCH',   0 ],
    [ HTTPMethod,    'PATCH',   1 ],
    [ HTTPMethod,    'FOO',     0 ],
);

foreach my $constraint (@constraints)
{
    my ($type, $value, $e_valid) = @$constraint;

    my $pretty_value = defined $value ? '"' . $value . '"' : '<undef>';

    my $invalid_message = $type->validate($value);

    ok(!$invalid_message, $pretty_value . ' is a valid ' . $type->name) if $e_valid;

    ok(
        $invalid_message,
        (defined $invalid_message ? $invalid_message : $pretty_value)
            . ' is not a valid ' . $type->name)
        if not $e_valid;
}

