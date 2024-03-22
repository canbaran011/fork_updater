abstract class AppTranslation {
  static Map<String, Map<String, String>> translationKeys = {
    "en_US": enUS,
    "tr_TR": trTR,
  };
}

final Map<String, String> enUS = {'hello': 'Welcome Kamer!'};

final Map<String, String> trTR = {'hello': 'Hoş Geldin Kamer !'};
