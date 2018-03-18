#!/usr/bin/env bash

# set -euo pipefail
# IFS=$'\n\t'

#/
#/ Usage: 
#/ ./whereami.sh [option]
#/ 
#/ Description:
#/ CLI "tool" and a bash "library" for getting and parsing users geolocation data
#/ 
#/ Examples:
#/ ./whereami.sh
#/ ./whereami.sh xml
#/ You can source this file and use it's functions
#/ get json-pretty
#/
#/ Options:

# shellcheck disable=SC1091
. bashclient/bashclient.sh

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*-h" > /dev/null && usage
expr "$*" : ".*--help" > /dev/null && usage

# Check if jq or python is installed for pretty print
json_support() {
  if command -v jq >/dev/null 2>&1; then
    echo "${1:-}" | jq
  elif command -v python >/dev/null 2>&1; then
    echo "${1:-}" | python -m json.tool
  else
    parse "${1:-}" 'json'
  fi
}

# Check if xmllint is installed for pretty print
xml_support() {
  if command -v xmllint >/dev/null 2>&1; then
    echo "${1:-}" | xmllint --format -
  else
     parse "${1:-}" 'xml' 
  fi
}

get() {
# shellcheck disable=SC2034
  SERVER="freegeoip.net"
# shellcheck disable=SC2034
  URLPATH="/${1:-"csv"}/"
# get_http is from bashclient.sh
  get_http
}

parse() {
  response="${1:-}"
  option="${2:-"coord"}"
  if [[ $option == 'coord' ]]; then
    echo "${response}" | cut -f9-10 -d','
  elif [[ $option == 'csv' ]]; then
    echo "${response}"
  elif [[ $option == 'json' ]]; then
    echo "${response}"
  elif [[ $option == 'json-pretty' ]]; then
    json_support "${response}"
  elif [[ $option == 'xml' ]]; then
    echo "${response}"
  elif [[ $option == 'xml-pretty' ]]; then
    xml_support "${response}"
  elif [[ $option == 'human' ]]; then
    echo "${response}" | cut -f6,3,2 -d','
  fi 
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then

  case "${1:-"coord"}" in
#/   coord returns only coordinates [default]
    coord)
      res=$(get)
      parse "${res}" 'coord'
    ;;
#/   csv returns result in CSV format
    csv)
      res=$(get)
      parse "${res}" 'csv'
    ;;
#/   json returns result in JSON format
    json)
      res=$(get json)
      parse "${res}" 'json'
    ;;
#/   json-pretty tries to return result in JSON pretty format
    json-pretty)
      res=$(get json)
      parse "${res}" 'json-pretty'
    ;;
#/   xml returns result in XML format
    xml)
      res=$(get xml)
      parse "${res}" 'xml'
    ;;
#/   xml-pretty tries to return result in XML pretty format
    xml-pretty)
      res=$(get xml)
      parse "${res}" 'xml-pretty'
    ;;
#/   human returns only location
    human)
      res=$(get)
      parse "${res}" 'human'
    ;;
#/   -h, --help: Display this help message
    *)
      usage
    ;;
  esac

fi
