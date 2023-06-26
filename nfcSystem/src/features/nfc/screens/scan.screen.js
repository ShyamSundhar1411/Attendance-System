import React, { useEffect } from "react";
import {
  SafeAreaView,
  Text,
  NativeEventEmitter,
  NativeModules,
  StyleSheet,
} from "react-native";
import NfcManager, { NfcTech } from "react-native-nfc-manager";

export const ScanScreen = () => {
  useEffect(() => {
    // Initialize NFC Manager
    NfcManager.start();

    // Register NFC events
    const nfcEmitter = new NativeEventEmitter(NativeModules.NfcManager);
    const nfcDiscoverTagListener = nfcEmitter.addListener(
      "NfcManagerDiscoverTag",
      async (data) => {
        try {
          if (data && data.techTypes.includes(NfcTech.NfcA)) {
            // Handle NFC-A tag data
            const tag = await NfcManager.getTag();
            console.log("NFC-A Tag:", tag);
          }
        } catch (error) {
          console.error("Error reading NFC tag:", error);
        }
      }
    );

    return () => {
      // Clean up NFC events and stop NFC Manager
      nfcDiscoverTagListener.remove();
      NfcManager.cancelTechnologyRequest().catch(() => 0);
      NfcManager.unregisterTagEvent().catch(() => 0);
      NfcManager.stop();
    };
  }, []);

  return (
    <View style={styles.wrapper}>
      <Text>Scan a Tag</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  wrapper: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
});
