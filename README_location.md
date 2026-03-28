# flutter_location

## 概要
本件は Flutter を用いた位置情報の取得をまとめました。

### 前提条件
Android Studio で作成のため、VSCode、その他 IDE での検証はありません。
（特に問題ないと思いますが）

#### 使用パッケージ
- [geolocator](https://pub.dev/packages/geolocator)
- [permission_handler](https://pub.dev/packages/permission_handler)

#### 使い方
1. permission_handler.dart を import してください。
2. 位置情報を取得するタイミングで以下コードを呼び出してください。

``` Flutter
Position? position = await LocationService().getCurrentLocation(context);
print(position?.latitude);
print(position?.longitude);
```

実行結果
```
flutter: 132.75683308515346
flutter: 33.86483312011503
```

#### 留意点
サービス側で位置情報取得の権限をチェックしています。
権限がない場合はキャンセル or 設定アプリに遷移する実装を行なっています。

そのため、アプリ側で権限のチェックを行う必要はありません。

以上（追加点あれば随時更新します）