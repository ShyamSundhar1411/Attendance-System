import { StatusBar as ExpoStatusBar, StatusBar } from "expo-status-bar";
import React from "react";
import { StyleSheet, SafeAreaView, Platform } from "react-native";
import { Text } from "../../../components/typography/text_component";

export const HomeScreen = () => {
  return (
    <>
      <SafeAreaView style={styles.androidSafeArea}>
        <Text style={{ textAlign: "center" }} variant="label">
          Hey
        </Text>
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
