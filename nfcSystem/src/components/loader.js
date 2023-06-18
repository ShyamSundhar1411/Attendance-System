import React from "react";
import { ActivityIndicator } from "react-native-paper";
import styled from "styled-components/native";

const LoaderView = styled.View`
  position: absolute;
  top: 50%;
  left: 50%;
`;
export const Loader = ({ isLoading }) => {
  return (
    <>
      {isLoading && (
        <LoaderView>
          <ActivityIndicator
            size={50}
            // eslint-disable-next-line react-native/no-inline-styles
            style={{ marginLeft: -25 }}
            color="#0000ff"
            animating={true}
          />
        </LoaderView>
      )}
    </>
  );
};
