diff --git a/ykpers-args.h b/ykpers-args.h
index 2a63268..9ff455a 100644
--- ykpers-args.h
+++ ykpers-args.h
@@ -33,8 +33,8 @@
 
 #include "ykpers.h"
 
-const char *usage;
-const char *optstring;
+extern const char *usage;
+extern const char *optstring;
 
 int args_to_config(int argc, char **argv, YKP_CONFIG *cfg, char *oathid,
 		   size_t oathid_len, const char **infname,
