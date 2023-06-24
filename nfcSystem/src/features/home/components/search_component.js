import React, { useState, useEffect } from "react";
import { Searchbar } from "react-native-paper";
import styled from "styled-components/native";
const SearchBarContainer = styled.View`
  padding: ${(props) => props.theme.space[3]};
`;
export const SearchBarComponent = () => {
  const [searchKeyword, setSearchKeyword] = useState("");
  return (
    <SearchBarContainer>
      <Searchbar
        value={searchKeyword}
        onChangeText={(text) => {
          setSearchKeyword(text);
        }}
        placeholder="Search"
      />
    </SearchBarContainer>
  );
};
