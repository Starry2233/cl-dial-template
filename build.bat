@echo off
REM XTC Dial Build Script — Java → DEX → APK → Signed .cl
REM
REM Prerequisites:
REM   - Android SDK build-tools 37.0.0
REM   - JDK 8+
REM   - Android Keystore
REM
REM Usage:
REM   build.bat cl

setlocal enabledelayedexpansion

set SDK=%USERPROFILE%\AppData\Local\Android\Sdk
set BT=%SDK%\build-tools\37.0.0
set ANDROID_JAR=%SDK%\platforms\android-34\android.jar
set KEYSTORE=E:\android.keystore
set KEYPASS=
set ALIAS=

if "%1"=="cl" goto build_cl
echo Usage: %0 cl
exit /b 1

:build_cl
set OUT=%CD%\build\cl
for /r src\main\java %%f in (*.java) do set SRC_FILES=!SRC_FILES! "%%f"
if "!SRC_FILES!"=="" echo No source files found & exit /b 1

mkdir "%OUT%\classes" 2>nul
javac -source 8 -target 8 -bootclasspath "%ANDROID_JAR%" -d "%OUT%\classes" !SRC_FILES!
if errorlevel 1 exit /b 1

set CLS_FILES=
for /r "%OUT%\classes" %%f in (*.class) do set CLS_FILES=!CLS_FILES! "%%f"
"%BT%\d8.bat" --lib "%ANDROID_JAR%" --release --output "%OUT%" !CLS_FILES!
if errorlevel 1 exit /b 1

copy "AndroidManifest.xml" "%OUT%\" >nul
pushd "%OUT%"
"%BT%\aapt" package -f -M AndroidManifest.xml -I "%ANDROID_JAR%" -F xtcwatch.apk
"%BT%\aapt" add xtcwatch.apk classes.dex
"%BT%\apksigner.bat" sign --ks "%KEYSTORE%" --ks-key-alias "%ALIAS%" --ks-pass "pass:%KEYPASS%" xtcwatch.apk
popd

mkdir "%~dp0output" 2>nul
copy "%OUT%\xtcwatch.apk" "%~dp0output\%~n0.cl" /y >nul
echo Build complete: %~dp0output\%~n0.cl
exit /b 0
