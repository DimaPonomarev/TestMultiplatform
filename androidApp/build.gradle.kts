plugins {
    alias(libs.plugins.androidApplication)
    alias(libs.plugins.kotlinAndroid)
    alias(libs.plugins.compose.compiler)
}

val composeVersion = "1.1.1"

android {
    namespace = "com.example.fifth.android"
    compileSdk = 34
    defaultConfig {
        applicationId = "com.example.fifth.android"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
    buildFeatures {
        compose = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = composeVersion
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
}

dependencies {
    implementation(projects.shared)
    implementation(libs.compose.ui)
    implementation(libs.compose.ui.tooling.preview)
    implementation(libs.compose.material3)
    implementation(libs.androidx.activity.compose)
    implementation(libs.androidx.foundation.layout)
    debugImplementation(libs.compose.ui.tooling)

    implementation(libs.androidx.foundation.v111)
    implementation(libs.androidx.runtime)
    // UI
    implementation(libs.androidx.ui.v111)
    implementation(libs.androidx.ui.tooling.v111)
    // Material Design
    implementation(libs.androidx.material)
    implementation(libs.androidx.material.icons.core)
    // Activity
    implementation(libs.androidx.activity.compose.v140)
    implementation(libs.androidx.appcompat)

    implementation(libs.androidx.lifecycle.viewmodel.compose)
}