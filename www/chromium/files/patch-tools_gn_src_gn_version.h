--- tools/gn/src/gn/version.h.orig	2021-04-14 18:49:11 UTC
+++ tools/gn/src/gn/version.h
@@ -15,9 +15,9 @@ class Version {
 
   static std::optional<Version> FromString(std::string s);
 
-  int major() const { return major_; }
-  int minor() const { return minor_; }
-  int patch() const { return patch_; }
+  int gmajor() const { return major_; }
+  int gminor() const { return minor_; }
+  int gpatch() const { return patch_; }
 
   bool operator==(const Version& other) const;
   bool operator<(const Version& other) const;
