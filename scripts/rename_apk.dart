/// Rename build/app/outputs/flutter-apk/app{-platform}-release.apk to release/{app_name}_v{version}{-platform}.apk
/// For example, release/myapp_v1.0.0-arm64.apk
import 'dart:io';
import 'package:yaml/yaml.dart';

void main() {
  // Load package name and version from pubspec.yaml
  var file = File('../pubspec.yaml');
  var contents = file.readAsStringSync();
  var yaml = loadYaml(contents);
  var name = yaml['name'];
  var version = yaml['version'].toString().substring(0, 5);

  // Get a list of all APK files in the build/app/outputs/flutter-apk directory
  var apkDir = Directory('../build/app/outputs/flutter-apk');
  var apkFiles = apkDir.listSync().where((file) => file.path.endsWith('-release.apk')).toList();

  // Rename and move each APK file
  var targetDirectory = "../release";
  for (var apkFile in apkFiles) {
    var oldName = apkFile.path.split('\\').last;
    var newPath = oldName.replaceAllMapped(RegExp(r'^app(-.+)?-(release\.apk)$'), (match) => "$targetDirectory/${name}_v$version${match[1] ?? ''}.apk");
    createDirectory(targetDirectory);
    var newFile = File(newPath);
    apkFile.renameSync(newFile.path);
    print("Rename ${apkFile.path} --> $newPath".replaceAll("../", ""));
  }
}

/// Create a directory if it does not exist
void createDirectory(String dir) {
  var releaseDir = Directory(dir);
  if (!releaseDir.existsSync()) {
    releaseDir.createSync();
  }
}