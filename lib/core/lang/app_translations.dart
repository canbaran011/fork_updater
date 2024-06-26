abstract class AppTranslation {
  static Map<String, Map<String, String>> translationKeys = {
    "en_US": enUS,
    "tr_TR": trTR,
  };
}

final Map<String, String> enUS = {
  'hello': 'Welcome Kamer!',
  'appBarTitle': 'Fork Updater for Kamer',
  'folderPathInput': 'Folder Path',
  'branchName': 'Branch Name',
  'folderPathInputHint': 'Please enter folder path of project',
  'branchNameHint': 'Please enter the branch name for sync and click add',
  'emptyInputMessage': 'Ooops ! Empty inputs makes me sad!',
  'syncTitle': 'SYNC',
  'emptyResult': 'Result will appear here',
  'emptyResultTooltip': 'Clear terminal view',
  'settingsTooltip': 'Settings for date and more...'
};

final Map<String, String> trTR = {
  'hello': 'Hoş Geldin Kamer !',
  'appBarTitle': 'Kamer için Fork Updater',
  'folderPathInput': 'Dosya Yolu',
  'branchName': 'Branch Adi',
  'folderPathInputHint': 'Lutfen projenin folder path ini giriniz',
  'branchNameHint': 'Lutfen branch adini giriniz ve artiya basiniz',
  'emptyInputMessage': 'Hoppala abicim bos birakma su inputlari ya',
  'syncTitle': 'SENKRONIZE ET',
  'emptyResult': 'Sonuclar burada goruntulenecektir',
  'emptyResultTooltip': 'Terminal gorunumunu temizle',
  'settingsTooltip': 'Tarih ve daha fazla ayar...'
};
