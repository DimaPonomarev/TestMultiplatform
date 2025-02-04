import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.kotlinCocoapods)
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
            baseName = "MultiPlatformLibrary"
            export("dev.icerock.moko:resources:$mokoResourcesVersion")  // необходимо для добавления mokoResources
            export("dev.icerock.moko:mvvm-core:$mokoMvvmVersion")
            export("dev.icerock.moko:mvvm-flow:$mokoMvvmVersion")
        }
    }
    
    sourceSets {
        val commonMain by getting {
            dependencies {
                api(libs.kotlinx.coroutines.core)

<<<<<<< HEAD
                api(libs.mvvm.core)
                api(libs.mvvm.flow)
=======
                api("dev.icerock.moko:mvvm-core:$mokoMvvmVersion")
                api("dev.icerock.moko:mvvm-flow:$mokoMvvmVersion")
                api("dev.icerock.moko:resources:$mokoResourcesVersion") // необходимо для добавления mokoResources
                api("dev.icerock.moko:resources-compose:$mokoResourcesVersion") // необходимо для добавления mokoResources
>>>>>>> test
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
//    то как будет называться импорт в файлах
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