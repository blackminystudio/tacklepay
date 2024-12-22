enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'TacklePay Dev';
      case Flavor.staging:
        return 'TacklePay Staging';
      case Flavor.prod:
        return 'TacklePay';
      default:
        return 'title';
    }
  }

}
