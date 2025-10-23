plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.wpdevusa.ost_ecommerce"

    // ✅ Explicitly set to 36 instead of flutter.compileSdkVersion
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        // ✅ You can safely use Java 17 for newer SDKs
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.wpdevusa.ost_ecommerce"

        // ✅ Explicit SDK versions (don’t rely on flutter.* constants)
        minSdk = 23
        targetSdk = 36

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Replace with your own signing config for release builds.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
