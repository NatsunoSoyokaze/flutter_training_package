///
/// バリデーション関連をまとめたクラス
class Validation {
  static final RegExp _emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>]).{6,18}$',
  );

  ///
  /// メールアドレスの整合性チェック
  static String? email(String text) {
    if (text.isEmpty) return "メールアドレスを入力してください";
    if (!_emailRegex.hasMatch(text)) return "メールアドレスの形式が正しくありません";
    return null;
  }

  ///
  /// パスワードの整合性チェック
  static String? password(String text) {
    if (text.isEmpty) {
      return "パスワードを入力してください";
    }

    if (!_passwordRegex.hasMatch(text)) {
      return "パスワードは6〜18文字で、大文字・小文字・数字・記号をそれぞれ1文字以上含めてください";
    }

    return null;
  }
}
