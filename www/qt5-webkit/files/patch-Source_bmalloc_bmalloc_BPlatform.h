armv6/v7:
See PR 222612

Add proper architecture name:
  https://gcc.gnu.org/ml/gcc-patches/2015-06/msg01679.html

--- Source/bmalloc/bmalloc/BPlatform.h.orig	2017-06-04 20:16:07 UTC
+++ Source/bmalloc/bmalloc/BPlatform.h
@@ -108,6 +108,7 @@
 #elif defined(__ARM_ARCH_6__) \
 || defined(__ARM_ARCH_6J__) \
 || defined(__ARM_ARCH_6K__) \
+|| defined(__ARM_ARCH_6KZ__) \
 || defined(__ARM_ARCH_6Z__) \
 || defined(__ARM_ARCH_6ZK__) \
 || defined(__ARM_ARCH_6T2__) \
@@ -147,6 +148,7 @@

 #elif defined(__ARM_ARCH_6J__) \
 || defined(__ARM_ARCH_6K__) \
+|| defined(__ARM_ARCH_6KZ__) \
 || defined(__ARM_ARCH_6Z__) \
 || defined(__ARM_ARCH_6ZK__) \
 || defined(__ARM_ARCH_6M__)
