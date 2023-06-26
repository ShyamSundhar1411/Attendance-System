import React from "react";
import { NavigationContainer } from "@react-navigation/native";
import { Ionicons, AntDesign } from "@expo/vector-icons";
import { Text } from "../../components/typography/text_component";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { HomeScreen } from "../../features/home/screens/home.screen";
import { ScanScreen } from "../../features/nfc/screens/scan.screen";
const Tab = createBottomTabNavigator();

const Tab_Icons = {
  Scan: "md-sync",
  User: "md-search",
};

const tabBarIcon =
  (iconName) =>
  ({ size, color }) =>
    <Ionicons name={iconName} size={size} color={color} />;
const screenOptions = ({ route }) => {
  const iconName = Tab_Icons[route.name];
  return {
    tabBarIcon: tabBarIcon(iconName),
    headerShown: false,
  };
};
export const Navigator = () => {
  return (
    <>
      <NavigationContainer>
        <Tab.Navigator screenOptions={screenOptions}>
          <Tab.Screen name="Scan" component={ScanScreen} />
          <Tab.Screen name="Users" component={HomeScreen} />
        </Tab.Navigator>
      </NavigationContainer>
    </>
  );
};
