extension StringX on String {
  String get capitalize => this[0].toUpperCase() + substring(1).toLowerCase();

  String get titleCase {
    if (isEmpty) return "";
    return trim().replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.capitalize).join(' ');
  }

  String get formatKey {
    return split("-").map((e) => e.titleCase).join(" ");
  }
}
