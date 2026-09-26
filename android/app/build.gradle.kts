plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing comes only from environment variables (CI secrets or a local
// shell). Without ANDROID_KEYSTORE_PATH the release build falls back to the
// debug key so `flutter build apk` still works for contributors; when the path
// is set, every other variable is mandatory and there are no default values.
val releaseKeystore: String? = System.getenv("ANDROID_KEYSTORE_PATH")

fun requiredEnv(name: String): String =
    System.getenv(name) ?: throw GradleException("Define $name para firmar la versión release")

android {
    namespace = "io.github.diegofranciscog.peuc"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "io.github.diegofranciscog.peuc"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (releaseKeystore != null) {
            create("release") {
                storeFile = file(releaseKeystore)
                storePassword = requiredEnv("ANDROID_KEYSTORE_PASSWORD")
                keyAlias = requiredEnv("ANDROID_KEY_ALIAS")
                keyPassword = requiredEnv("ANDROID_KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName(if (releaseKeystore != null) "release" else "debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
