icon:
	flutter clean
	flutter pub get
	flutter pub run flutter_launcher_icons:main

apk:
	flutter build apk --split-per-abi
	
iosfix:
	rm -rf pubspec.lock ios/Pods ios/Podfile.lock
	flutter pub get
	pod install --repo-update --project-directory=ios
