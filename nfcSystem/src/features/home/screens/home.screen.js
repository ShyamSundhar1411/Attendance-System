import React, { useEffect } from "react";
import { StyleSheet, SafeAreaView, Platform, StatusBar } from "react-native";
import { SearchBarComponent } from "../components/search_component";
import { UserCard } from "../components/user.detail.card";
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
