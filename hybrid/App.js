import React from 'react';
import { StyleSheet, View, Image } from 'react-native';
import { createAppContainer, TouchableOpacity } from "react-navigation";
import { createStackNavigator } from "react-navigation-stack";

import WelcomeScreen  from './src/screen/WelcomeScreen'





const AppNavigator = createStackNavigator({
  Welcome: {
    screen: WelcomeScreen
  }
});

const AppContainer = createAppContainer(AppNavigator);

export default class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <AppContainer style={styles.appCintainer}/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
container: {
  flex: 1,
  backgroundColor: '#FF0000',
  alignContent:'center',
  justifyContent: 'center',
},
appCintainer: {
  flex: 1,
  backgroundColor: '#00FF00',
  alignContent:'center',
  justifyContent: 'center',
},
});

