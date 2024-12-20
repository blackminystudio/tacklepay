enum FlavorTypes {
  dev,
  staging,
  prod,
}

class Flavors {
  static FlavorTypes? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case FlavorTypes.dev:
        return 'TacklePay Dev';
      case FlavorTypes.staging:
        return 'TacklePay Staging';
      case FlavorTypes.prod:
        return 'TacklePay';
      default:
        return 'title';
    }
  }
}
