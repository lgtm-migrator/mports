--- src/3rdparty/chromium/base/trace_event/process_memory_dump.cc.orig	2018-11-13 18:25:11 UTC
+++ src/3rdparty/chromium/base/trace_event/process_memory_dump.cc
@@ -93,7 +93,7 @@ size_t ProcessMemoryDump::CountResidentBytes(void* sta
 #if defined(OS_WIN)
   std::unique_ptr<PSAPI_WORKING_SET_EX_INFORMATION[]> vec(
       new PSAPI_WORKING_SET_EX_INFORMATION[max_vec_size]);
-#elif defined(OS_MACOSX)
+#elif defined(OS_MACOSX) || defined(OS_BSD)
   std::unique_ptr<char[]> vec(new char[max_vec_size]);
 #elif defined(OS_POSIX) || defined(OS_FUCHSIA)
   std::unique_ptr<unsigned char[]> vec(new unsigned char[max_vec_size]);
