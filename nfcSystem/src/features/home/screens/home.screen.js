import React, { useEffect, useContext } from "react";
import { StyleSheet, SafeAreaView, Platform, StatusBar } from "react-native";
import { SearchBarComponent } from "../components/search_component";
import { UserCard } from "../components/user.detail.card";
import { NFCUserContext } from "../../../services/users/user.context";
export const HomeScreen = () => {
  const { users, isLoading, error } = useContext(NFCUserContext);
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
