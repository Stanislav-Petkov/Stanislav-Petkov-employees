part of 'error_model.dart';

class NoFileSelectedErrorModel extends ErrorModel
    implements L10nErrorKeyProvider {

  @override
  String get l10nErrorKey => I18nErrorKeys.noFileSelected;

  @override
  String toString() => 'NoFileSelectedError.';
}
