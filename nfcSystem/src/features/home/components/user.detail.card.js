import React from "react";
import { Card } from "react-native-paper";
import styled from "styled-components/native";
import { Text } from "../../../components/typography/text_component";
import { TouchableOpacity } from "react-native";
const CardContainer = styled.View`
  padding: ${(props) => props.theme.space[3]};
`;
export const UserCard = ({ user }) => {
  const { username, email, roll_no, faculty_registered } = user;
  return (
    <CardContainer>
      <Card>
        <Card.Title title={username} subtitle={roll_no} />
        <Card.Content>
          <Text>{email}</Text>
          <Text>{faculty_registered}</Text>
        </Card.Content>
      </Card>
    </CardContainer>
  );
};
