--- gpu/command_buffer/tests/gl_test_utils.cc.orig	2020-09-08 19:14:06 UTC
+++ gpu/command_buffer/tests/gl_test_utils.cc
@@ -24,7 +24,7 @@
 #include "ui/gl/gl_version_info.h"
 #include "ui/gl/init/gl_factory.h"
 
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
 #include "ui/gl/gl_image_native_pixmap.h"
 #endif
 
@@ -446,7 +446,7 @@ void GpuCommandBufferTestEGL::RestoreGLDefault() {
   window_system_binding_info_ = gl::GLWindowSystemBindingInfo();
 }
 
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
 scoped_refptr<gl::GLImageNativePixmap>
 GpuCommandBufferTestEGL::CreateGLImageNativePixmap(gfx::BufferFormat format,
                                                    gfx::Size size,
