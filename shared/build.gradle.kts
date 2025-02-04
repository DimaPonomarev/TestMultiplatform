import com.android.utils.TraceUtils.simpleId
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.kotlinCocoapods) // добавление cocoaPods
    alias(libs.plugins.androidLibrary)
    id("dev.icerock.mobile.multiplatform-resources") // необходимо для добавления mokoResources
    id("co.touchlab.skie") version "0.9.3"
}
val mokoMvvmVersion = "0.13.0"
val mokoResourcesVersion = "0.24.3"


kotlin {
    androidTarget {
        compilations.all {
            compileTaskProvider.configure {
                compilerOptions {
                    jvmTarget.set(JvmTarget.JVM_1_8)
                }
            }
        }
    }
    iosX64()
    iosArm64()
    iosSimulatorArm64()


    cocoapods {
        summary = "Some description for the Shared Module"
        homepage = "Link to the Shared Module homepage"
        version = "1.0"
        ios.deploymentTarget = "16.0"
        podfile = project.file("../iosApp/Podfile")
        framework {
            baseName = "MultiPlatformLibrary" //    то как будет называться импорт в файлах
            export(libs.resources)  // необходимо для добавления mokoResources
            export(libs.mvvm.core)  // необходимо для добавления moko-MVVM
            export(libs.mvvm.flow)  // необходимо для добавления moko-MVVM
        }
    }
    
    sourceSets {
        val commonMain by getting {
            dependencies {
                api(libs.kotlinx.coroutines.core)

                api(libs.mvvm.core)
                api(libs.mvvm.flow)
                api(libs.resources) // необходимо для добавления mokoResources
                api(libs.resources.compose) // необходимо для добавления mokoResources
            }
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
        val androidMain by getting {
            dependencies {
                api(libs.mvvm.flow.compose)
            }
        }
    }
}

// необходимо для добавления mokoResources
multiplatformResources {
    iosBaseLocalizationRegion = "ru"
    resourcesPackage.set("com.example.new")
}

android {
    namespace = "com.example.fifth"
    compileSdk = 34
    defaultConfig {
        minSdk = 24
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}