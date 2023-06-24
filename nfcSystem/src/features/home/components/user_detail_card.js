import React from "react";
import { Card, Button, Avatar } from "react-native-paper";
import styled from "styled-components/native";
import { Text } from "../../../components/typography/text_component";

const CardContainer = styled.View`
  padding: ${(props) => props.theme.space[3]};
`;
export const UserCard = () => {
  const LeftContent = (props) => <Avatar.Icon {...props} icon="folder" />;
  return (
    <CardContainer>
      <Card>
        <Card.Title
          title="Card Title"
          subtitle="Card Subtitle"
          left={LeftContent}
        />
        <Card.Content>
          <Text>Card title</Text>
          <Text>Card content</Text>
        </Card.Content>
      </Card>
    </CardContainer>
  );
};
