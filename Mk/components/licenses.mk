

Licenses_Include_MAINTAINER=         ports@MidnightBSD.org

.if defined(_POSTMKINCLUDED) && !defined(BEFOREPORTMK)

# Meta ports set these and we currently don't install the files if this is there
# TODO: make license catalog always install
.if defined(NO_INSTALL)
NO_LICENSES_INSTALL=yes
.endif

# List of valid licenses
.if !target(license-list)
license-list:
	@${ECHO_MSG} ${_LICENSES}
.endif

# Include known licenses from database
# Must be done so that license-list target works
.include "${PORTSDIR}/Mk/components/licenses.db.mk"

.if defined(LICENSE)

# Lists of variables and valid components
#
# _LICENSE_LIST_PERMS		- Valid permission components
# _LICENSE_LIST_PORT_VARS	- License variables defined by the port

_LICENSE_LIST_PERMS=		dist-mirror dist-sell pkg-mirror pkg-sell auto-accept none
_LICENSE_LIST_PORT_VARS=	PERMS NAME GROUPS

# Path variables
#
# _LICENSE_DIR		- Directory to install licenses
# _LICENSE_DIR_REL	- Same as above, without ${PREFIX}
# _LICENSE_STORE	- Store for known license files
# _LICENSE_CATALOG	- License catalog (make include file) to be created (dst)
# _LICENSE_CATALOG_TMP	- Same as above, but in WRKDIR (src)
# _LICENSE_REPORT	- License summary, shows licenses and how they are combined (dst)
# _LICENSE_REPORT_TMP	- Same as above, but in WRKDIR (src)
# _LICENSE_COOKIE	- Set when license is accepted, it is not present in
# 					  bsd.port.mk to avoid creating LICENSE_{REQ,SEQ} for a
# 					  few more targets only.

_LICENSE_DIR?=		${PREFIX}/share/licenses/${PKGNAME}
_LICENSE_DIR_REL?=	share/licenses/${PKGNAME}
_LICENSE_STORE?=	${PORTSDIR}/Templates/Licenses
_LICENSE_CATALOG?=	${_LICENSE_DIR}/catalog.mk
_LICENSE_CATALOG_TMP?=	${WRKDIR}/.license-catalog.mk
_LICENSE_REPORT?=	${_LICENSE_DIR}/LICENSE
_LICENSE_REPORT_TMP?=	${WRKDIR}/.license-report
_LICENSE_COOKIE?=	${WRKDIR}/.license_done.${PORTNAME}.${PREFIX:S/\//_/g}

# Defaults (never overriden for now)
#
# _LICENSE			- Copy of LICENSE (for now)
# _LICENSE_COMB		- Copy of LICENSE_COMB (but "single" instead of empty)

_LICENSE?=			${LICENSE}
.if !defined(LICENSE_COMB)
_LICENSE_COMB=		single
.else
_LICENSE_COMB=		${LICENSE_COMB}
.endif

# Check if single or dual/multiple license
#
# Make sure LICENSE_COMB is only used with more than one license.

.if ${_LICENSE_COMB} != "single" && ${_LICENSE_COMB} != "dual" && ${_LICENSE_COMB} != "multi"
_LICENSE_ERROR?=	invalid value for LICENSE_COMB: "${_LICENSE_COMB}" (should be "single", "dual" or "multi")
.endif

.for lic in ${_LICENSE}
.	if defined(_LICENSE_DEFINED)
.		if ${_LICENSE_COMB} == "single"
_LICENSE_ERROR?=	multiple licenses in LICENSE, but LICENSE_COMB is set to "single" (or undefined)
.		else
_LICENSE_MULTI=		yes
.		endif
.	else
_LICENSE_DEFINED=	yes
.	endif
.endfor
.if ${_LICENSE_COMB} != "single" && !defined(_LICENSE_MULTI)
_LICENSE_ERROR?=	single license in LICENSE, but LICENSE_COMB is set to "${_LICENSE_COMB}" (requires more than one)
.endif
.if !defined(_LICENSE_DEFINED)
_LICENSE_ERROR?=	no licenses present in LICENSE (empty string)
.endif
.undef _LICENSE_DEFINED
.undef _LICENSE_MULTI

# Evaluate port license groups and permissions
#
# Available values for _LICENSE_TYPE:
#
# Case 1: "known" (license info taken from internal database)
# Case 2: "unknown" (LICENSE is not known, and info taken from port)
#
# Make sure required variables are defined, and remove conflicting (positive
# and negative) duplicated components.

.if ${_LICENSE_COMB} == "single"
# Defaults to empty
_LICENSE_GROUPS?=	#
# Start
.	for lic in ${_LICENSE}
.		if ${_LICENSES:M${lic}} != ""
# Case 1: license defined in the framework.
_LICENSE_TYPE=		known
.			for var in ${_LICENSE_LIST_PORT_VARS}
.				if defined(LICENSE_${var})
_LICENSE_ERROR?=	redefining LICENSE_${var} is not allowed for known licenses, to define a custom license try another LICENSE name like ${_LICENSE}-variant
.				endif
.				if !defined(_LICENSE_${var}_${lic})
_LICENSE_ERROR?=	ERROR: missing _LICENSE_${var}_${lic} in licenses.db.mk
.				else
_LICENSE_${var}=	${_LICENSE_${var}_${lic}}
.				endif
.			endfor
# Check for LICENSE_FILE or at least LICENSE_TEXT (which simulates it)
.			if !defined(LICENSE_FILE)
.				if !defined(LICENSE_TEXT)
.					if exists(${_LICENSE_STORE}/${lic})
_LICENSE_FILE=		${_LICENSE_STORE}/${lic}
.					else
# No license file in /usr/mports/Licenses
_LICENSE_TEXT=		The license: ${_LICENSE} (${_LICENSE_NAME}) is standard, please read from the web.
_LICENSE_FILE=		${WRKDIR}/${lic}
.					endif
.				else
_LICENSE_ERROR?=	defining LICENSE_TEXT is not allowed for known licenses
.				endif
.			else
_LICENSE_FILE=		${LICENSE_FILE}
.			endif

.		else
# Case 2: license only known by the port.
_LICENSE_TYPE=		unknown
.			for var in ${_LICENSE_LIST_PORT_VARS}
.				if defined(LICENSE_${var})
_LICENSE_${var}=	${LICENSE_${var}}
.				elif !defined(_LICENSE_${var})
_LICENSE_ERROR?=	for unknown licenses, defining LICENSE_${var} is mandatory (otherwise use a known LICENSE)
.				endif
.			endfor
# Check LICENSE_PERMS for invalid, ambiguous and duplicate components
__LICENSE_PERMS:=	#
.			for comp in ${_LICENSE_PERMS}
.				if ${_LICENSE_LIST_PERMS:M${comp:C/^no-//}} == ""
_LICENSE_ERROR?=	invalid LICENSE_PERMS component "${comp}"
.				elif ${__LICENSE_PERMS:M${comp}} == "" && \
					 ${_LICENSE_PERMS:Mno-${comp:C/^no-//}} == ""
__LICENSE_PERMS+=	${comp}
.				endif
.			endfor
_LICENSE_PERMS:=	${__LICENSE_PERMS}
.			undef __LICENSE_PERMS
# Check for LICENSE_FILE or at least LICENSE_TEXT (which simulates it)
.			if !defined(LICENSE_FILE)
.				if !defined(LICENSE_TEXT)
_LICENSE_ERROR?=	either LICENSE_FILE or LICENSE_TEXT must be defined
.				else
_LICENSE_TEXT=		${LICENSE_TEXT}
_LICENSE_FILE=		${WRKDIR}/${lic}
.				endif
.			else
_LICENSE_FILE=		${LICENSE_FILE}
.			endif
.		endif

# Only one is allowed
.		if defined(LICENSE_FILE) && defined(LICENSE_TEXT)
_LICENSE_ERROR?=	defining both LICENSE_FILE and LICENSE_TEXT is not allowed
.		endif
# Distfiles
.		if !defined(LICENSE_DISTFILES)
_LICENSE_DISTFILES=	${_DISTFILES}
.		else
_LICENSE_DISTFILES=	${LICENSE_DISTFILES}
.		endif
.	endfor

.else
.	for lic in ${_LICENSE}
# Defaults to empty
_LICENSE_GROUPS_${lic}?=#
.		if ${_LICENSES:M${lic}} != ""
# Case 1: license defined in the framework.
_LICENSE_TYPE_${lic}=	known
.			for var in ${_LICENSE_LIST_PORT_VARS}
.				if defined(LICENSE_${var}_${lic})
_LICENSE_ERROR?=	redefining LICENSE_${var}_${lic} is not allowed for known licenses, to define a custom license try another LICENSE name for ${lic} like ${lic}-variant
.				endif
.				if !defined(_LICENSE_${var}_${lic})
_LICENSE_ERROR?=	ERROR: missing _LICENSE_${var}_${lic} in bsd.licenses.db.mk
.				endif
.			endfor
# Check for LICENSE_FILE or at least LICENSE_TEXT (which simulates it)
.			if !defined(LICENSE_FILE_${lic})
.				if !defined(LICENSE_TEXT_${lic})
.					if exists(${_LICENSE_STORE}/${lic})
_LICENSE_FILE_${lic}=		${_LICENSE_STORE}/${lic}
.					else
#  No license file in /usr/ports/Templates/Licenses
_LICENSE_TEXT_${lic}=	The license: ${lic} (${_LICENSE_NAME_${lic}}) is standard, please read from the web.
_LICENSE_FILE_${lic}=	${WRKDIR}/${lic}
.					endif
.				else
_LICENSE_ERROR?=	defining LICENSE_TEXT_${lic} is not allowed for known licenses
.				endif
.			else
_LICENSE_FILE_${lic}=	${LICENSE_FILE_${lic}}
.			endif

.		else
# Case 2: license only known by the port.
_LICENSE_TYPE_${lic}=	unknown
.			for var in ${_LICENSE_LIST_PORT_VARS}
.				if defined(LICENSE_${var}_${lic})
_LICENSE_${var}_${lic}=	${LICENSE_${var}_${lic}}
.				elif !defined(_LICENSE_${var}_${lic})
_LICENSE_ERROR?=	for unknown licenses, defining LICENSE_${var}_${lic} is mandatory (otherwise use a known LICENSE)
.				endif
.			endfor
# Check LICENSE_PERMS for invalid, ambiguous and duplicate components
__LICENSE_PERMS:=	#
.			for comp in ${_LICENSE_PERMS_${lic}}
.				if ${_LICENSE_LIST_PERMS:M${comp:C/^no-//}} == ""
_LICENSE_ERROR?=		invalid LICENSE_PERMS_${var} component "${comp}"
.				elif ${__LICENSE_PERMS:M${comp}} == "" && \
					 ${_LICENSE_PERMS_${lic}:Mno-${comp:C/^no-//}} == ""
__LICENSE_PERMS+=		${comp}
.				endif
.			endfor
_LICENSE_PERMS_${lic}:=	${__LICENSE_PERMS}
.			undef __LICENSE_PERMS
# Check for LICENSE_FILE or at least LICENSE_TEXT (which simulates it)
.			if !defined(LICENSE_FILE_${lic})
.				if !defined(LICENSE_TEXT_${lic})
_LICENSE_ERROR?=		either LICENSE_FILE_${lic} or LICENSE_TEXT_${lic} must be defined
.				else
_LICENSE_TEXT_${lic}=	${LICENSE_TEXT_${lic}}
_LICENSE_FILE_${lic}=	${WRKDIR}/${lic}
.				endif
.			else
_LICENSE_FILE_${lic}=	${LICENSE_FILE_${lic}}
.			endif
.		endif

# Only one is allowed
.		if defined(LICENSE_FILE_${lic}) && defined(LICENSE_TEXT_${lic})
_LICENSE_ERROR?=		defining both LICENSE_FILE_${lic} and LICENSE_TEXT_${lic}is not allowed
.		endif
# Distfiles
.		if !defined(LICENSE_DISTFILES_${lic})
_LICENSE_DISTFILES_${lic}=	${_DISTFILES}
.		else
_LICENSE_DISTFILES_${lic}=	${LICENSE_DISTFILES_${lic}}
.		endif
.	endfor
.endif

# Check if the user agrees with the license

# Make sure these are defined

LICENSES_ACCEPTED?=			#
LICENSES_REJECTED?=			#
LICENSES_GROUPS_ACCEPTED?=	#
LICENSES_GROUPS_REJECTED?=	#

# Evaluate per-license status

.if ${_LICENSE_COMB} == "single"
.	for lic in ${_LICENSE}
.		if ${LICENSES_REJECTED:M${lic}} != ""
_LICENSE_STATUS?=	rejected
.		endif
.		for group in ${_LICENSE_GROUPS}
.			if ${LICENSES_GROUPS_REJECTED:M${group}} != ""
_LICENSE_STATUS?=	rejected
.			endif
.			if ${LICENSES_GROUPS_ACCEPTED:M${group}} != ""
_LICENSE_STATUS?=	accepted
.			endif
.		endfor
.		if ${LICENSES_ACCEPTED:M${lic}} != ""
_LICENSE_STATUS?=	accepted
.		endif
.		if ${_LICENSE_PERMS:Mauto-accept} != "" && !defined(LICENSES_ASK)
_LICENSE_STATUS?=	accepted
.		endif
_LICENSE_STATUS?=	ask
.	endfor

.else
.	for lic in ${_LICENSE}
.		if ${LICENSES_REJECTED:M${lic}} != ""
_LICENSE_STATUS_${lic}?=	rejected
.		endif
.		for group in ${_LICENSE_GROUPS_${lic}}
.			if ${LICENSES_GROUPS_REJECTED:M${group}} != ""
_LICENSE_STATUS_${lic}?=	rejected
.			endif
.			if ${LICENSES_GROUPS_ACCEPTED:M${group}} != ""
_LICENSE_STATUS_${lic}?=	accepted
.			endif
.		endfor
.		if ${LICENSES_ACCEPTED:M${lic}} != ""
_LICENSE_STATUS_${lic}?=	accepted
.		endif
.		if ${_LICENSE_PERMS_${lic}:Mauto-accept} != "" && !defined(LICENSES_ASK)
_LICENSE_STATUS_${lic}?=	accepted
.		endif
_LICENSE_STATUS_${lic}?=	ask
.	endfor
.endif

# Evaluate general status

.if ${_LICENSE_COMB} == "dual"
.	for lic in ${_LICENSE}
.		if ${_LICENSE_STATUS_${lic}} == "accepted"
_LICENSE_STATUS=	accepted
.		elif ${_LICENSE_STATUS_${lic}} == "ask"
_LICENSE_STATUS?=	ask
_LICENSE_TO_ASK+=	${lic}
.		endif
_LICENSE_STATUS?=	rejected
.	endfor

.elif ${_LICENSE_COMB} == "multi"
.	for lic in ${_LICENSE}
.		if ${_LICENSE_STATUS_${lic}} == "rejected"
_LICENSE_STATUS=	rejected
.		elif ${_LICENSE_STATUS_${lic}} == "ask"
_LICENSE_STATUS?=	ask
_LICENSE_TO_ASK+=	${lic}
.		endif
.	endfor
_LICENSE_STATUS?=	accepted
.endif

# For dual/multi licenses, after processing all sub-licenses, the following
# must be determined: _LICENSE_NAME, _LICENSE_PERMS and _LICENSE_GROUPS.

.if ${_LICENSE_COMB} == "dual"
_LICENSE_NAME=		Dual (any of): ${_LICENSE}
# Calculate least restrictive permissions (union)
_LICENSE_PERMS:=	#
.	for lic in ${_LICENSE}
.		for comp in ${_LICENSE_LIST_PERMS}
.			if ${_LICENSE_PERMS_${lic}:M${comp}} != "" && \
			   ${_LICENSE_PERMS:M${comp}} == ""
_LICENSE_PERMS+=	${comp}
.			endif
.		endfor
.	endfor
# Calculate least restrictive groups (union)
_LICENSE_GROUPS:=	#
.	for lic in ${_LICENSE}
.		for comp in ${_LICENSE_LIST_GROUPS}
.			if ${_LICENSE_GROUPS_${lic}:M${comp}} != "" && \
			   ${_LICENSE_GROUPS:M${comp}} == ""
_LICENSE_GROUPS+=	${comp}
.			endif
.		endfor
.	endfor

.elif ${_LICENSE_COMB} == "multi"
_LICENSE_NAME=		Multiple (all of): ${_LICENSE}
# Calculate most restrictive permissions (intersection)
_LICENSE_PERMS:=	${_LICENSE_LIST_PERMS}
.	for lic in ${_LICENSE}
.		for comp in ${_LICENSE_LIST_PERMS}
.			if ${_LICENSE_PERMS_${lic}:M${comp}} == ""
_LICENSE_PERMS:=	${_LICENSE_PERMS:N${comp}}
.			endif
.		endfor
.	endfor
# Calculate most restrictive groups (intersection)
_LICENSE_GROUPS:=	${_LICENSE_LIST_GROUPS}
.	for lic in ${_LICENSE}
.		for comp in ${_LICENSE_LIST_GROUPS}
.			if ${_LICENSE_GROUPS_${lic}:M${comp}} == ""
_LICENSE_GROUPS:=	${_LICENSE_GROUPS:N${comp}}
.			endif
.		endfor
.	endfor
.endif

# Prepare information for asking license to the user

.if ${_LICENSE_STATUS} == "ask" && ${_LICENSE_COMB} != "single"
_LICENSE_ASK_DATA!=	mktemp -ut portslicense
.endif

# Calculate restrictions and set RESTRICTED_FILES when
# appropiate, together with cleaning targets.
#
# XXX For multiple licenses restricted distfiles are always removed from both
# CDROM and FTP, but the current framework supports separating them (would
# require better/new delete-package and delete-distfiles targets)

.if ${_LICENSE_PERMS:Mpkg-mirror} == ""
_LICENSE_RESTRICTED+=	delete-package
.elif ${_LICENSE_PERMS:Mpkg-sell} == ""
_LICENSE_CDROM+=		delete-package
.endif

.if ${_LICENSE_COMB} == "multi"
.	for lic in ${_LICENSE}
.		if ${_LICENSE_PERMS_${lic}:Mdist-mirror} == "" || ${_LICENSE_PERMS_${lic}:Mdist-sell} == ""
RESTRICTED_FILES+=		${_LICENSE_DISTFILES_${lic}}
.		endif
.	endfor
.	if defined(RESTRICTED_FILES)
RESTRICTED_FILES+=		${_PATCHFILES}
_LICENSE_RESTRICTED+=	delete-distfiles
_LICENSE_CDROM+=		delete-distfiles
.	endif
.else
.	if ${_LICENSE_PERMS:Mdist-mirror} == ""
_LICENSE_RESTRICTED+=	delete-distfiles
RESTRICTED_FILES=		${_PATCHFILES} ${_DISTFILES}
.	elif ${_LICENSE_PERMS:Mdist-sell} == ""
_LICENSE_CDROM+=		delete-distfiles
RESTRICTED_FILES=		${_PATCHFILES} ${_DISTFILES}
.	endif
.endif

.if defined(_LICENSE_RESTRICTED)
clean-restricted:	${_LICENSE_RESTRICTED}
clean-restricted-list: ${_LICENSE_RESTRICTED:C/$/-list/}
.else
clean-restricted:
clean-restricted-list:
.endif

.if defined(_LICENSE_CDROM)
clean-for-cdrom:	${_LICENSE_CDROM}
clean-for-cdrom-list: ${_LICENSE_CDROM:C/$/-list/}
.else
clean-for-cdrom:
clean-for-cdrom-list:
.endif

# Check variables are correctly defined and print status up to here

.if ${_LICENSE_STATUS} == "ask" && defined(BATCH)
# Allow magus to build packages anyway
.if defined(PACKAGE_BUILDING)
_LICENSE_STATUS=	"accepted"
.else
IGNORE=		License ${_LICENSE} needs confirmation, but BATCH is defined
.endif
.endif

check-license:
.if defined(_LICENSE_ERROR)
		@${ECHO_MSG} "===>  License not correctly defined: ${_LICENSE_ERROR}"
		@exit 1
.endif
.if ${_LICENSE_STATUS} == "rejected"
		@${ECHO_MSG} "===>  License ${_LICENSE} rejected by the user"
		@${ECHO_MSG}
		@${ECHO_MSG} "If you want to install this port make sure the following license(s) are not present in LICENSES_REJECTED, either in make arguments or /etc/make.conf: ${_LICENSE}. Also check LICENSES_GROUPS_REJECTED in case they contain a group this license(s) belong to." | ${FMT}
		@${ECHO_MSG}
		@exit 1
.elif ${_LICENSE_STATUS} == "accepted"
		@${ECHO_MSG} "===>  License ${_LICENSE} accepted by the user"
.elif ${_LICENSE_STATUS} == "ask"
		@${ECHO_MSG} "===>  License ${_LICENSE} needs confirmation, will ask later"
.endif

# Display, ask and save preference if requested

.if !target(ask-license)
ask-license: ${_LICENSE_COOKIE}

${_LICENSE_COOKIE}:
# Make sure all required license files exist
.if ${_LICENSE_COMB} == "single"
.	if !defined(LICENSE_FILE) && defined(_LICENSE_TEXT)
	@test -f ${_LICENSE_FILE} || ${ECHO_CMD} "${_LICENSE_TEXT}" | ${FMT} > ${_LICENSE_FILE}
.	endif
	@test -f ${_LICENSE_FILE} || \
		(${ECHO_MSG} "===>  Missing license file for ${_LICENSE} in ${_LICENSE_FILE}"; exit 1)
.else
.	for lic in ${_LICENSE}
.		if !defined(LICENSE_FILE_${lic}) && defined(_LICENSE_TEXT_${lic})
	@test -f ${_LICENSE_FILE_${lic}} || ${ECHO_CMD} "${_LICENSE_TEXT_${lic}}" | ${FMT} > ${_LICENSE_FILE_${lic}}
.		endif
	@test -f ${_LICENSE_FILE_${lic}} || \
		(${ECHO_MSG} "===>  Missing license file for ${lic} in ${_LICENSE_FILE_${lic}}"; exit 1)
.	endfor
.endif

.endif
# end !target ask-license

.if ${_LICENSE_STATUS} == "ask"
.	if !defined(NO_LICENSES_DIALOGS)
# Dialog interface
.		if ${_LICENSE_COMB} == "single"
	@trap '${RM} -f $$tmpfile' EXIT INT TERM; \
	tmpfile=$$(mktemp -t portlicenses); \
	while true; do \
		${DIALOG} --menu "License for ${PKGNAME} (${_LICENSE})" 21 70 15 accept "Accept license" reject "Reject license" view "View license" 2>"$${tmpfile}"; \
		result=`${CAT} $${tmpfile}`; \
		case $${result} in \
		accept) break ;; \
		reject) exit 1;; \
		view)   ${DIALOG} --textbox "${_LICENSE_FILE}" 21 75 ;; \
		esac; \
	done

.		elif ${_LICENSE_COMB} == "dual"
	@${RM} -f ${_LICENSE_ASK_DATA}
.			for lic in ${_LICENSE_TO_ASK}
	@${ECHO_CMD} "${lic}:${_LICENSE_FILE_${lic}}" >> ${_LICENSE_ASK_DATA}
.			endfor
	@menu_cmd="${DIALOG} --hline \"This port requires you to accept at least one license\" --menu \"License for ${PKGNAME} (dual)\" 21 70 15"; \
	trap '${RM} -f $$tmpfile' EXIT INT TERM; \
	tmpfile=$$(mktemp -t portlicenses); \
	for lic in ${_LICENSE_TO_ASK}; do \
		menu_cmd="$${menu_cmd} VIEW_$${lic} \"View the license $${lic}\" USE_$${lic} \"Accept the license $${lic}\""; \
	done; \
	menu_cmd="$${menu_cmd} REJECT \"Reject the licenses (all)\""; \
	while true; do \
		${SH} -c "$${menu_cmd} 2>\"$${tmpfile}\""; \
		result=$$(${CAT} "$${tmpfile}"); \
		case $${result} in \
		REJECT) exit 1;; \
		VIEW_*) name=$$(${ECHO_CMD} $${result} | ${SED} -e 's/^VIEW_//'); \
				file=$$(${GREP} "^$${name}:" ${_LICENSE_ASK_DATA} | ${CUT} -d : -f 2); \
				${DIALOG} --textbox "$${file}" 21 75 ;; \
		USE_*)  name=$$(${ECHO_CMD} $${result} | ${SED} -e 's/^USE_//'); \
				${ECHO_CMD} $${name} > ${_LICENSE_COOKIE}; \
				break ;; \
		esac; \
	done

.		elif ${_LICENSE_COMB} == "multi"
	@${RM} -f ${_LICENSE_ASK_DATA}
.			for lic in ${_LICENSE_TO_ASK}
	@${ECHO_CMD} "${lic}:${_LICENSE_FILE_${lic}}" >> ${_LICENSE_ASK_DATA}
.			endfor
	@menu_cmd="${DIALOG} --hline \"This port requires you to accept all mentioned licenses\" --menu \"License for ${PKGNAME} (multi)\" 21 70 15"; \
	trap '${RM} -f $$tmpfile' EXIT INT TERM; \
	tmpfile=$$(mktemp -t portlicenses); \
	for lic in ${_LICENSE_TO_ASK}; do \
		menu_cmd="$${menu_cmd} VIEW_$${lic} \"View the license $${lic}\""; \
	done; \
	menu_cmd="$${menu_cmd} ACCEPT \"Accept the licenses (all)\" REJECT \"Reject the licenses (all)\""; \
	while true; do \
		${SH} -c "$${menu_cmd} 2>\"$${tmpfile}\""; \
		result=$$(${CAT} "$${tmpfile}"); \
		case $${result} in \
		ACCEPT) break ;; \
		REJECT) exit 1 ;; \
		VIEW_*) name=$$(${ECHO_CMD} $${result} | ${SED} -e 's/^VIEW_//'); \
				file=$$(${GREP} "^$${name}:" ${_LICENSE_ASK_DATA} | ${CUT} -d : -f 2); \
				${DIALOG} --textbox "$${file}" 21 75 ;; \
		esac; \
	done
.		endif

.	else
# Text interface
	@${ECHO_MSG}
.		if ${_LICENSE_COMB} == "single"
	@${ECHO_MSG} "To install the port you must agree to the license: ${_LICENSE} (${_LICENSE_NAME})." | ${FMT}
	@${ECHO_MSG}
	@${ECHO_MSG} "You can view the license at ${_LICENSE_FILE:S/${WRKDIR}\//${WRKDIR:T}\//}."
.		elif ${_LICENSE_COMB} == "dual"
	@${ECHO_MSG} "To install the port you must agree to any of the following licenses:"
.		elif ${_LICENSE_COMB} == "multi"
	@${ECHO_MSG} "To install the port you must agree to all of the following licenses:"
.		endif
	@${ECHO_MSG}
.		if ${_LICENSE_COMB} != "single"
.			for lic in ${_LICENSE_TO_ASK}
	@${ECHO_MSG} "- ${lic} (${_LICENSE_NAME_${lic}}), available at ${_LICENSE_FILE_${lic}:S/${WRKDIR}\//${WRKDIR:T}\//}"
.			endfor
	@${ECHO_MSG}
.		endif
	@${ECHO_MSG} "If you agree with the corresponding license(s), add them to LICENSES_ACCEPTED either in make arguments or /etc/make.conf." | ${FMT}
	@${ECHO_MSG}
	@exit 1
.	endif
	@${RM} -f ${_LICENSE_ASK_DATA}
.endif

# Create report and catalog
.if !defined(NO_LICENSES_INSTALL)
	@${RM} -f ${_LICENSE_CATALOG_TMP} ${_LICENSE_REPORT_TMP}
.	if ${_LICENSE_COMB} == "single"
# Catalog
.		for var in _LICENSE _LICENSE_NAME _LICENSE_PERMS _LICENSE_GROUPS _LICENSE_DISTFILES
	@${ECHO_CMD} "${var}=${${var}:C/^[[:blank:]]*//}" >> ${_LICENSE_CATALOG_TMP}
.		endfor
# Report
	@${ECHO_CMD} "This package has a single license: ${_LICENSE} (${_LICENSE_NAME})." > ${_LICENSE_REPORT_TMP}
.	else
# Catalog
.		for var in _LICENSE _LICENSE_COMB _LICENSE_NAME _LICENSE_PERMS _LICENSE_GROUPS
	@${ECHO_CMD} "${var}=${${var}:C/^[[:blank:]]*//}" >> ${_LICENSE_CATALOG_TMP}
.		endfor
.		if ${_LICENSE_COMB} == "dual" && ${_LICENSE_STATUS} == "ask"
	@${SED} -e 's/^/_LICENSE_SELECTED=/' ${_LICENSE_COOKIE} >> ${_LICENSE_CATALOG_TMP}
.		endif
.		for lic in ${_LICENSE}
.			for var in NAME PERMS GROUPS DISTFILES
	@${ECHO_CMD} "_LICENSE_${var}_${lic}=${_LICENSE_${var}_${lic}:C/^[[:blank:]]*//}" >> ${_LICENSE_CATALOG_TMP}
.			endfor
.		endfor
# Report
.		if ${_LICENSE_COMB} == "dual"
	@${ECHO_CMD} "This package has dual licenses (any of):"  >> ${_LICENSE_REPORT_TMP}
.		elif ${_LICENSE_COMB} == "multi"
	@${ECHO_CMD} "This package has multiple licenses (all of):"  >> ${_LICENSE_REPORT_TMP}
.		endif
.		for lic in ${_LICENSE}
	@${ECHO_CMD} "- ${lic} (${_LICENSE_NAME_${lic}})"  >> ${_LICENSE_REPORT_TMP}
.		endfor
.	endif
.endif

# Cookie (done here)
	@${TOUCH} ${_LICENSE_COOKIE}

# Package list entries, and installation

.if !defined(NO_LICENSES_INSTALL)
PLIST_FILES+=	${_LICENSE_DIR_REL}/${_LICENSE_CATALOG:T} \
				${_LICENSE_DIR_REL}/${_LICENSE_REPORT:T}

.if ${_LICENSE_COMB} == "single"
PLIST_FILES+=	${_LICENSE_DIR_REL}/${_LICENSE}
.else
.	for lic in ${_LICENSE}
.		if defined(_LICENSE_FILE_${lic})
PLIST_FILES+=	${_LICENSE_DIR_REL}/${lic}
.		endif
.	endfor
.endif

install-license:
	@${MKDIR} ${FAKE_DESTDIR}${_LICENSE_DIR}
	@${INSTALL_DATA} ${_LICENSE_CATALOG_TMP} ${FAKE_DESTDIR}${_LICENSE_CATALOG}
	@${INSTALL_DATA} ${_LICENSE_REPORT_TMP} ${FAKE_DESTDIR}${_LICENSE_REPORT}
.if ${_LICENSE_COMB} == "single"
	@${INSTALL_DATA} ${_LICENSE_FILE} ${FAKE_DESTDIR}${_LICENSE_DIR}/${_LICENSE}
.else
.	for lic in ${_LICENSE}
	@${INSTALL_DATA} ${_LICENSE_FILE_${lic}} ${FAKE_DESTDIR}${_LICENSE_DIR}/${lic}
.	endfor
.endif
# XXX @dirrmtry entry must be here (no way to do with PLIST_* vars)
	@${ECHO_CMD} "@owner root" >> ${TMPPLIST}
	@${ECHO_CMD} "@group wheel" >> ${TMPPLIST}
	@${ECHO_CMD} "@cwd ${PREFIX}" >> ${TMPPLIST}
	@${ECHO_CMD} "@dirrm ${_LICENSE_DIR_REL}" >> ${TMPPLIST}
	@${ECHO_CMD} "@unexec rmdir %D/share/licenses 2>/dev/null || true" >> ${TMPPLIST}

.endif

.else	# !LICENSE

check-license:
.	if defined(LICENSE_VERBOSE) || defined(MPORT_MAINTAINER_MODE)
	@${ECHO_MSG} "===>  License check disabled, port has not defined LICENSE"
.	endif

.endif	# LICENSE

.endif
