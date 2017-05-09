# Bash HTTP Client

CLI geolocation tool using [bashclient](https://github.com/vandot/bashclient) for HTTP requests abusing freegeoip.net API.

Output can be only coordinates, only location, CSV, JSON or XML. For prettier JSON and XML output tool will try to use [jq](https://stedolan.github.io/jq/) and [xmllint](http://xmlsoft.org/xmllint.html).

## Requirements

  1. `bash`, 3 or later
  2. `netcat` to handle socket connections

## Installation

```sh
Git clone or copy paste whereami.sh and bashclient.sh or docker pull vandot/whereami
```

## Example usage

You can use whereami as a CLI tool with arguments.

```sh
$ ./whereami.sh
$ 144.8186,120.4681

$ ./whereami.sh json
$ {"ip":"","country_code":"","country_name":"","region_code":"","region_name":"","city":"","zip_code":"","time_zone":"","latitude":144.8186,"longitude":120.4681,"metro_code":0}

$ ./whereami.sh human
$ CODE,COUNTRY,CITY

$ docker run --rm vandot/casbab
$ 144.8186,120.4681
```