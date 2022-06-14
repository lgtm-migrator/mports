--- components/policy/core/browser/policy_pref_mapping_test.cc.orig	2021-05-12 22:05:50 UTC
+++ components/policy/core/browser/policy_pref_mapping_test.cc
@@ -279,6 +279,8 @@ class PolicyTestCase {
     const std::string os("chromeos");
 #elif defined(OS_LINUX)
     const std::string os("linux");
+#elif defined(OS_FREEBSD)
+    const std::string os("freebsd");
 #else
 #error "Unknown platform"
 #endif
