import 'package:flutter_test/flutter_test.dart';
import 'package:nfc/util/validation.dart';

void main() {
  group("Email validation", () {
    test("正常なメールアドレス", () {
      final result = Validation.email("test@example.com");

      expect(result, null);
    });

    test("空文字エラー", () {
      final result = Validation.email("");

      expect(result, "メールアドレスを入力してください");
    });

    test("フォーマットエラー", () {
      final result = Validation.email("testexample.com");

      expect(result, "メールアドレスの形式が正しくありません");
    });
  });

  group("Password validation", () {
    test("正常なパスワード", () {
      final result = Validation.password("Abc123!");
      expect(result, null);
    });

    test("短すぎる", () {
      final result = Validation.password("Ab1!");
      expect(result, isNotNull);
    });

    test("大文字なし", () {
      final result = Validation.password("abc123!");
      expect(result, isNotNull);
    });

    test("数字なし", () {
      final result = Validation.password("Abcdef!");
      expect(result, isNotNull);
    });

    test("特殊文字なし", () {
      final result = Validation.password("Abc12345");
      expect(result, isNotNull);
    });
  });
}