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
import { Card, Button, Avatar } from "react-native-paper";
import { SearchBarComponent } from "../components/search_component";
import { UserCard } from "../components/user_detail_card";
export const HomeScreen = () => {
  return (
    <>
      <SafeAreaView style={styles.androidSafeArea}>
        <SearchBarComponent />
        <UserCard />
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
