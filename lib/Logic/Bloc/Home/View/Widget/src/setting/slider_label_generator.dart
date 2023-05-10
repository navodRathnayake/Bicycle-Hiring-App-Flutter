library slider_label_generator;

class SliderLabelGenerator {
  static const String small = '0.0';
  static const String recommended = '33.33333333333333';
  static const String large = '66.66666666666666';
  static const String largest = '100.0';

  static String generator({required String fontSize}) {
    switch (fontSize) {
      case small:
        return 'small';
      case recommended:
        return 'recommended';
      case large:
        return 'large';
      case largest:
        return 'largest';
      default:
        return 'error';
    }
  }
}
