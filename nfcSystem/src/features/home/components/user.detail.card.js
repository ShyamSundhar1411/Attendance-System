import React from "react";
import { Card } from "react-native-paper";
import styled from "styled-components/native";
import { Text } from "../../../components/typography/text_component";
import { TouchableOpacity } from "react-native";
const CardContainer = styled.View`
  padding: ${(props) => props.theme.space[3]};
`;
export const UserCard = () => {
  return (
    <CardContainer>
      <Card>
        <Card.Title title="Card Title" subtitle="Card Subtitle" />
        <Card.Content>
          <Text>Card title</Text>
          <Text>Card content</Text>
        </Card.Content>
      </Card>
    </CardContainer>
  );
};
