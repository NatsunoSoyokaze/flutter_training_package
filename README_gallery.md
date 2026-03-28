# 概要
本件は Flutter を用いたギャラリー、写真から画像取得をまとめました。

## 前提条件
Android Studio で作成のため、VSCode、その他 IDE での検証はありません。
（特に問題ないと思いますが）

### 使用パッケージ
- [image_picker](https://pub.dev/packages/image_picker)
- [permission_handler](https://pub.dev/packages/permission_handler)

### 使い方
1. permission_handler.dart を import してください。
2. 写真一覧を取得したいタイミングで以下コードを呼び出してください。

``` Flutter
_photoService.pickImage(context)
```

### 留意点
サービス側で位置情報取得の権限をチェックしています。
権限がない場合はキャンセル or 設定アプリに遷移する実装を行なっています。

そのため、アプリ側で権限のチェックを行う必要はありません。

以上（追加点あれば随時更新します）