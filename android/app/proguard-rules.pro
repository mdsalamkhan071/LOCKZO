
# LOCKZO ProGuard Rules

# Keep Flutter embedding classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Kotlin metadata
-keep class kotlin.Metadata { *; }

# Keep biometric and authentication classes
-keep class androidx.biometric.** { *; }
