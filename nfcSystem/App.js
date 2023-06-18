import React from "react";
import { ThemeProvider } from "styled-components/native";
import { theme } from "./src/infrastructure/theme/index";
import { HomeScreen } from "./src/features/home/screens/home.screen";

export default function App() {
  return (
    <>
      <ThemeProvider theme={theme}>
        <HomeScreen />
      </ThemeProvider>
    </>
  );
}
