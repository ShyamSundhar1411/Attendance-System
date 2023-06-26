import React, { useEffect, useContext } from "react";
import {
  StyleSheet,
  SafeAreaView,
  Platform,
  StatusBar,
  FlatList,
  TouchableOpacity,
} from "react-native";
import { SearchBarComponent } from "../components/search_component";
import { UserCard } from "../components/user.detail.card";
import { Loader } from "../../../components/loader";
import { NFCUserContext } from "../../../services/users/user.context";
export const HomeScreen = () => {
  const { users, isLoading, error } = useContext(NFCUserContext);
  return (
    <>
      <SafeAreaView style={styles.androidSafeArea}>
        <SearchBarComponent />
        <Loader isLoading={isLoading} />
        <FlatList
          data={users}
          renderItem={({ item }) => {
            return (
              <TouchableOpacity
                onPress={() => {
                  console.log(item);
                }}
              >
                <UserCard user={item} />
              </TouchableOpacity>
            );
          }}
        />
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
