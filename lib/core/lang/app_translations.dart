abstract class AppTranslation {
  static Map<String, Map<String, String>> translationKeys = {
    "en_US": enUS,
    "tr_TR": trTR,
  };
}

final Map<String, String> enUS = {
  'hello': 'Welcome Kamer!',
  'folderPathInput': 'Please enter folder path of project',
  'branchName': 'Please enter the branch name for sync'
};

final Map<String, String> trTR = {
  'hello': 'Hoş Geldin Kamer !',
  'folderPathInput': 'Lutfen projenin folder path ini giriniz',
  'branchName': 'Lutfen branch adini giriniz'
};
