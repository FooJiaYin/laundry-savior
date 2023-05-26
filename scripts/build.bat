pushd "%~dp0\.."

rem Build APKs
call flutter build apk
call flutter build apk --split-per-abi

rem Rename and move APK files
cd scripts
call dart rename_apk.dart

popd