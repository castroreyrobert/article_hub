buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Add this line for the Google Services plugin
        // Check for the latest compatible version (e.g., 4.3.15, 4.4.0, 4.4.1)
        // See: https://firebase.google.com/docs/android/setup#add-gradle-plugin
        classpath("com.google.gms:google-services:4.4.1") // Or your desired version

        // You might also have a Kotlin Gradle plugin classpath here if not defined elsewhere,
        // though modern Flutter projects often handle this slightly differently.
        // Example: classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.20") // Match your Kotlin version
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
