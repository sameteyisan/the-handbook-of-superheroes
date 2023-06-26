icon:
	flutter clean
	flutter pub get
	flutter pub run flutter_launcher_icons:main

apk:
	flutter build apk --split-per-abi
