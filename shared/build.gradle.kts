import com.android.utils.TraceUtils.simpleId
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    alias(libs.plugins.kotlinMultiplatform)
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

    val iosTargets = listOf(iosX64(), iosArm64(), iosSimulatorArm64())
    iosTargets.forEach {
        it.binaries.framework() {
            baseName = "multi"
            isStatic = true

            linkerOpts.add("-lsqlite3")
            linkerOpts.add("-ld64")
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
                api(libs.androidx.lifecycle.viewmodel.android)

            }
        }
    }
}

// необходимо для добавления mokoResources
multiplatformResources {
    iosBaseLocalizationRegion = "ru"
    resourcesPackage.set("ru.test")
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
dependencies {
    implementation(libs.androidx.lifecycle.viewmodel.android)
}
