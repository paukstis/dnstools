DNS tools to help manage zone files

## replacezoneaip.sh
Requires perl, replaces given hostname A record with specified IP, can be
called from PPPd/DHCPd when your ISP changes your IP.

## soaserialup.sh
Requires perl, increments DNS zone serial number in SOA record, uses
`YYYYMMDDZZ` format, where `YYYYMMDD` is current date and `ZZ` auto
incrementing number for the same day starting with `01` and left
padded with zero.
