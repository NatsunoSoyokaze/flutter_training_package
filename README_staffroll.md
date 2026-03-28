# 概要
本件はスタッフロールの動作をまとめました。
映画のスタッフロールをイメージした画面になります。

## 前提条件
JSON ファイルを読み込み音楽を流すため、JSON、音声データを事前用意が必要になります。

### 使用パッケージ
- [audioplayers](https://pub.dev/packages/audioplayers)

### 使い方
1. assets/audio/ 配下に使用する音源を配置してください。
2. 以下のような JSON ファイルを assets/staff/ に配置してください。
```JSON
[
  { "title": "DIRECTOR", "name": "Soyokaze" },
  { "title": "ENGINEER", "name": "Flutter Dev" },
  { "title": "DESIGNER", "name": "UI Master" }
]
```
3. staff_roll_screen.dart に画面遷移します。

### 留意点
画面遷移後は自動でスタッフロールが始まります。
スワイプ操作は禁止しています。

以上（追加点あれば随時更新します）