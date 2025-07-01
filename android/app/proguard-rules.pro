# Flutter Stripe Plugin
-keep class com.stripe.stripesdk.** { *; }
-keep interface com.stripe.stripesdk.** { *; }

# Stripe Android SDK Core
-keep class com.stripe.android.** { *; }
-keep interface com.stripe.android.** { *; }

# حذف قواعد React Native (لأنك تستخدم Flutter)
# -keep class com.reactnativestripesdk.** { *; }

# إضافة قواعد عامة للـ R8
-dontwarn com.stripe.android.pushProvisioning.**
-dontwarn com.reactnativestripesdk.**

# حفظ كلاسات Kotlin
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider