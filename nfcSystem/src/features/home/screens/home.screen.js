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
import styled from "styled-components/native";
import { SearchBarComponent } from "../components/search_component";

export const HomeScreen = () => {
  return (
    <>
      <SafeAreaView style={styles.androidSafeArea}>
        <SearchBarComponent />
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
