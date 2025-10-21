plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.nutrirional.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.nutrirional.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        ndk {
            debugSymbolLevel = "none"
        }
    }

    buildTypes {
        getByName("release") {
            // Use debug key for now; replace with your release key when publishing
            signingConfig = signingConfigs.getByName("debug")

            // ✅ Enable all compression + shrinking
            isMinifyEnabled = true
            isShrinkResources = true
            isDebuggable = false

            // ✅ Use optimized ProGuard configuration
            setProguardFiles(
                listOf(
                    getDefaultProguardFile("proguard-android-optimize.txt"),
                    "proguard-rules.pro"
                )
            )
        }

        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    packaging {
        resources {
            excludes += "META-INF/*"
        }
    }
}

flutter {
    source = "../.."
}
