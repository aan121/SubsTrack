
import React from 'react';
import { Platform } from 'react-native';

import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import { enableScreens } from 'react-native-screens';


import Splash from "../Screens/Splash";
import Login from "../Screens/AuthScreen/Login";
import SignUp from "../Screens/AuthScreen/SignUp";
import BottomNavigation from "./BottomNavigation";

type RootStackParamList = {
  Splash: undefined,
  Login: undefined,
  SignUp: undefined,
  BottomNavigation: undefined,
};

// type AuthStackParamList = {
//   Login: { value: string } | undefined,
// };


enableScreens();


const RootStack = createStackNavigator<RootStackParamList>();


export const THEME_COLOR = '#0AAF60';

export const setNavigator = (nav: any) => {
  const navigator = nav;
};

export default function RootNavigator() {
  return (

    <NavigationContainer>
      <RootStack.Navigator initialRouteName="Splash"
        screenOptions={{
          headerShown: false,
        }}>
        <RootStack.Screen name='Splash' component={Splash} options={{ headerShown: false }} />
        <RootStack.Screen name='Login' component={Login} options={{ headerShown: false }} />
        <RootStack.Screen name='SignUp' component={SignUp} options={{ headerShown: false }} />
        <RootStack.Screen name='BottomNavigation' component={BottomNavigation} options={{ headerShown: false }} />

        {/*  */}
      </RootStack.Navigator>
    </NavigationContainer>

  );
}

