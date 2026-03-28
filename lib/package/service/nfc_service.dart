import 'package:nfc_manager/nfc_manager.dart';

class NfcService {

  void startNfc() async {
    bool available = await NfcManager.instance.isAvailable();

    if (!available) {
      print("NFC使えない");
      return;
    }

    NfcManager.instance.startSession(
      pollingOptions: {
        NfcPollingOption.iso14443,
        NfcPollingOption.iso15693,
        NfcPollingOption.iso18092,
      },
      onDiscovered: (NfcTag tag) async {

        print("カード検出");
        print(tag.data);

        NfcManager.instance.stopSession();
      },
    );
  }}