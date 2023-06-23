import React, { useEffect } from "react";
import {
  StyleSheet,
  SafeAreaView,
  Platform,
  StatusBar,
  TouchableOpacity,
  View,
} from "react-native";
import { Text } from "../../../components/typography/text_component";
import NfcManager, { NfcEvents } from "react-native-nfc-manager";
import styled from "styled-components/native";

export const HomeScreen = () => {
  const handleTagDiscovery = async () => {
    console.log("NFC card detected");
  };
  useEffect(() => {
    NfcManager.start();
    NfcManager.setEventListener(NfcEvents.DiscoverTag, handleTagDiscovery);
    return () => {
      NfcManager.setEventListener(NfcEvents.DiscoverTag, null);
      NfcManager.cancelTechnologyRequest().catch(() => {});
      NfcManager.unregisterTagEvent().catch(() => {});
    };
  }, []);

  return (
    <>
      <SafeAreaView style={styles.androidSafeArea}>
        <Text>Scan the Tag</Text>
      </SafeAreaView>
    </>
  );
};
const styles = StyleSheet.create({
  androidSafeArea: {
    flex: 1,
    marginTop: Platform.OS === "android" ? StatusBar.currentHeight : 0,
  },
});
