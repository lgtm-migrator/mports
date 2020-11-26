--- chrome/browser/about_flags.cc.orig	2020-09-08 19:13:59 UTC
+++ chrome/browser/about_flags.cc
@@ -184,7 +184,7 @@
 #include "ui/gl/gl_switches.h"
 #include "ui/native_theme/native_theme_features.h"
 
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
 #include "base/allocator/buildflags.h"
 #endif
 
@@ -840,7 +840,7 @@ const FeatureEntry::Choice kMemlogSamplingRateChoices[
      heap_profiling::kMemlogSamplingRate5MB},
 };
 
-#if defined(OS_LINUX) || defined(OS_MACOSX) || defined(OS_WIN)
+#if defined(OS_LINUX) || defined(OS_MACOSX) || defined(OS_WIN) || defined(OS_BSD)
 const FeatureEntry::FeatureParam kOmniboxDocumentProviderServerScoring[] = {
     {"DocumentUseServerScore", "true"},
     {"DocumentUseClientScore", "false"},
@@ -1005,7 +1005,7 @@ const FeatureEntry::FeatureVariation kOmniboxRichAutoc
         nullptr,
     }};
 
-#endif  // defined(OS_LINUX) || defined(OS_MACOSX) || defined(OS_WIN)
+#endif  // defined(OS_LINUX) || defined(OS_MACOSX) || defined(OS_WIN) || defined(OS_BSD)
 
 const FeatureEntry::FeatureParam kOmniboxOnFocusSuggestionsParamSERP[] = {
     {"ZeroSuggestVariant:6:*", "RemoteSendUrl"},
@@ -2495,13 +2495,13 @@ const FeatureEntry kFeatureEntries[] = {
      flag_descriptions::kCloudPrintXpsDescription, kOsWin,
      SINGLE_VALUE_TYPE(switches::kEnableCloudPrintXps)},
 #endif  // OS_WIN
-#if defined(OS_WIN) || defined(OS_LINUX) || defined(OS_CHROMEOS)
+#if defined(OS_WIN) || defined(OS_LINUX) || defined(OS_CHROMEOS) || defined(OS_BSD)
     {"enable-webgl2-compute-context",
      flag_descriptions::kWebGL2ComputeContextName,
      flag_descriptions::kWebGL2ComputeContextDescription,
      kOsWin | kOsLinux | kOsCrOS,
      SINGLE_VALUE_TYPE(switches::kEnableWebGL2ComputeContext)},
-#endif  // defined(OS_WIN) || defined(OS_LINUX) || defined(OS_CHROMEOS)
+#endif  // defined(OS_WIN) || defined(OS_LINUX) || defined(OS_CHROMEOS) || defined(OS_BSD)
     {"enable-webgl-draft-extensions",
      flag_descriptions::kWebglDraftExtensionsName,
      flag_descriptions::kWebglDraftExtensionsDescription, kOsAll,
@@ -2689,7 +2689,7 @@ const FeatureEntry kFeatureEntries[] = {
      flag_descriptions::kEnableOfflinePreviewsDescription, kOsAndroid,
      FEATURE_VALUE_TYPE(previews::features::kOfflinePreviews)},
 #endif  // OS_ANDROID
-#if defined(OS_CHROMEOS) || defined(OS_LINUX)
+#if defined(OS_CHROMEOS) || defined(OS_LINUX) || defined(OS_BSD)
     {"enable-save-data", flag_descriptions::kEnableSaveDataName,
      flag_descriptions::kEnableSaveDataDescription, kOsCrOS | kOsLinux,
      SINGLE_VALUE_TYPE(
@@ -2699,7 +2699,7 @@ const FeatureEntry kFeatureEntries[] = {
      flag_descriptions::kEnableNavigationPredictorDescription,
      kOsCrOS | kOsLinux,
      FEATURE_VALUE_TYPE(blink::features::kNavigationPredictor)},
-#endif  // OS_CHROMEOS || OS_LINUX
+#endif  // OS_CHROMEOS || OS_LINUX || OS_BSD
     {"enable-preconnect-to-search",
      flag_descriptions::kEnablePreconnectToSearchName,
      flag_descriptions::kEnablePreconnectToSearchDescription, kOsAll,
@@ -3437,7 +3437,7 @@ const FeatureEntry kFeatureEntries[] = {
      FEATURE_VALUE_TYPE(
          omnibox::kHistoryQuickProviderAllowMidwordContinuations)},
 
-#if defined(OS_LINUX) || defined(OS_MACOSX) || defined(OS_WIN)
+#if defined(OS_LINUX) || defined(OS_MACOSX) || defined(OS_WIN) || defined(OS_BSD)
     {"omnibox-experimental-keyword-mode",
      flag_descriptions::kOmniboxExperimentalKeywordModeName,
      flag_descriptions::kOmniboxExperimentalKeywordModeDescription, kOsDesktop,
@@ -3487,7 +3487,7 @@ const FeatureEntry kFeatureEntries[] = {
      FEATURE_WITH_PARAMS_VALUE_TYPE(omnibox::kRichAutocompletion,
                                     kOmniboxRichAutocompletionVariations,
                                     "OmniboxBundledExperimentV1")},
-#endif  // defined(OS_LINUX) || defined(OS_MACOSX) || defined(OS_WIN)
+#endif  // defined(OS_LINUX) || defined(OS_MACOSX) || defined(OS_WIN) || defined(OS_BSD)
 
     {"enable-speculative-service-worker-start-on-query-input",
      flag_descriptions::kSpeculativeServiceWorkerStartOnQueryInputName,
@@ -3731,13 +3731,13 @@ const FeatureEntry kFeatureEntries[] = {
      flag_descriptions::kClickToOpenPDFDescription, kOsAll,
      FEATURE_VALUE_TYPE(features::kClickToOpenPDFPlaceholder)},
 
-#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX)
+#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD)
     {"direct-manipulation-stylus",
      flag_descriptions::kDirectManipulationStylusName,
      flag_descriptions::kDirectManipulationStylusDescription,
      kOsWin | kOsMac | kOsLinux,
      FEATURE_VALUE_TYPE(features::kDirectManipulationStylus)},
-#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX)
+#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD)
 
 #if !defined(OS_ANDROID)
     {"ntp-confirm-suggestion-removals",
@@ -4423,7 +4423,7 @@ const FeatureEntry kFeatureEntries[] = {
      FEATURE_VALUE_TYPE(kClickToCallUI)},
 #endif  // BUILDFLAG(ENABLE_CLICK_TO_CALL)
 
-#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || \
+#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD) || \
     defined(OS_CHROMEOS)
     {"remote-copy-receiver", flag_descriptions::kRemoteCopyReceiverName,
      flag_descriptions::kRemoteCopyReceiverDescription, kOsDesktop,
@@ -4440,7 +4440,7 @@ const FeatureEntry kFeatureEntries[] = {
      flag_descriptions::kRemoteCopyProgressNotificationName,
      flag_descriptions::kRemoteCopyProgressNotificationDescription, kOsDesktop,
      FEATURE_VALUE_TYPE(kRemoteCopyProgressNotification)},
-#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) ||
+#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD) ||
         // defined(OS_CHROMEOS)
 
     {"shared-clipboard-ui", flag_descriptions::kSharedClipboardUIName,
@@ -4466,7 +4466,7 @@ const FeatureEntry kFeatureEntries[] = {
      FEATURE_VALUE_TYPE(
          send_tab_to_self::kSendTabToSelfOmniboxSendingAnimation)},
 
-#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || \
+#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD) || \
     defined(OS_CHROMEOS)
     {"sharing-peer-connection-receiver",
      flag_descriptions::kSharingPeerConnectionReceiverName,
@@ -4477,7 +4477,7 @@ const FeatureEntry kFeatureEntries[] = {
      flag_descriptions::kSharingPeerConnectionSenderName,
      flag_descriptions::kSharingPeerConnectionSenderDescription, kOsDesktop,
      FEATURE_VALUE_TYPE(kSharingPeerConnectionSender)},
-#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) ||
+#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD) ||
         // defined(OS_CHROMEOS)
 
     {"sharing-prefer-vapid", flag_descriptions::kSharingPreferVapidName,
@@ -4552,13 +4552,13 @@ const FeatureEntry kFeatureEntries[] = {
      FEATURE_VALUE_TYPE(printing::features::kEnableCustomMacPaperSizes)},
 #endif
 
-#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || \
+#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD) || \
     defined(OS_CHROMEOS)
     {"enable-reopen-tab-in-product-help",
      flag_descriptions::kReopenTabInProductHelpName,
      flag_descriptions::kReopenTabInProductHelpDescription, kOsDesktop,
      FEATURE_VALUE_TYPE(feature_engagement::kIPHReopenTabFeature)},
-#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) ||
+#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD) ||
         // defined(OS_CHROMEOS)
 
     {"enable-audio-focus-enforcement",
@@ -5020,7 +5020,7 @@ const FeatureEntry kFeatureEntries[] = {
      flag_descriptions::kEnableSyncTrustedVaultDescription, kOsAll,
      FEATURE_VALUE_TYPE(switches::kSyncSupportTrustedVaultPassphrase)},
 
-#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX)
+#if defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD)
     {"global-media-controls", flag_descriptions::kGlobalMediaControlsName,
      flag_descriptions::kGlobalMediaControlsDescription,
      kOsWin | kOsMac | kOsLinux,
@@ -5043,7 +5043,7 @@ const FeatureEntry kFeatureEntries[] = {
      flag_descriptions::kGlobalMediaControlsSeamlessTransferDescription,
      kOsWin | kOsMac | kOsLinux,
      FEATURE_VALUE_TYPE(media::kGlobalMediaControlsSeamlessTransfer)},
-#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX)
+#endif  // defined(OS_WIN) || defined(OS_MACOSX) || defined(OS_LINUX) || defined(OS_BSD)
 
 #if BUILDFLAG(ENABLE_SPELLCHECK) && defined(OS_WIN)
     {"win-use-native-spellchecker",
