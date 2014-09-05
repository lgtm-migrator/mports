CVE-2014-0191

From 9cd1c3cfbd32655d60572c0a413e017260c854df Mon Sep 17 00:00:00 2001
From: Daniel Veillard <veillard@redhat.com>
Date: Tue, 22 Apr 2014 15:30:56 +0800
Subject: Do not fetch external parameter entities

Unless explicitely asked for when validating or replacing entities
with their value. Problem pointed out by Daniel Berrange <berrange@redhat.com>

diff --git a/parser.c b/parser.c
index 9347ac9..c0dea05 100644
--- parser.c
+++ parser.c
@@ -2598,6 +2598,20 @@ xmlParserHandlePEReference(xmlParserCtxtPtr ctxt) {
 		    xmlCharEncoding enc;
 
 		    /*
+		     * Note: external parsed entities will not be loaded, it is
+		     * not required for a non-validating parser, unless the
+		     * option of validating, or substituting entities were
+		     * given. Doing so is far more secure as the parser will
+		     * only process data coming from the document entity by
+		     * default.
+		     */
+                    if ((entity->etype == XML_EXTERNAL_PARAMETER_ENTITY) &&
+		        ((ctxt->options & XML_PARSE_NOENT) == 0) &&
+			((ctxt->options & XML_PARSE_DTDVALID) == 0) &&
+			(ctxt->validate == 0))
+			return;
+
+		    /*
 		     * handle the extra spaces added before and after
 		     * c.f. http://www.w3.org/TR/REC-xml#as-PE
 		     * this is done independently.
-- 
cgit v0.10.1

