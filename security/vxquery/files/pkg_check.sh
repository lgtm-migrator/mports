#! /bin/sh
VXQUERY="vxquery"
PORTSDIR="${PORTSDIR:-/usr/mports}"
FORMAT="${FORMAT:-text}"
VULN_XML="${VULN_XML:-${PORTSDIR}/security/vuxml/vuln-flat.xml}"

set -e
/usr/libexec/mport.list | "${VXQUERY}" -f - -t "${FORMAT}" "${VULN_XML}"
