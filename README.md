# CL Dial Template

Traditional XTC watch face (.cl) project template.

## Structure

```
├── src/main/java/com/xtc/example/
│   └── DialViewImpl.java    # Main dial entry point
├── AndroidManifest.xml       # Android manifest
├── build.bat                 # Build script (Java → DEX → APK → .cl)
├── config.json               # Dial configuration
└── deploy.json               # Deployment info
```

## Usage

1. Click **"Use this template"** to create a new repo
2. Rename package `com.xtc.example` to your package name
3. Edit `DialViewImpl.java` with your watch face logic
4. Run `build.bat cl` to compile
5. Deploy the `.cl` file to your device

## Requirements

- Android SDK build-tools 37.0.0+
- JDK 8+
- Android Keystore for signing
