import React from 'react';
import {
  View,
  Image,
  Platform,
  Text,
  TouchableOpacity
} from 'react-native';

import Images from '../Styles/Images';
import Colors from '../Styles/Colors';

import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import { heightPercentageToDP as hp } from 'react-native-responsive-screen';

import Home from "../Screens/MainScreen/Home";
import Wallet from "../Screens/MainScreen/Wallet";
import Profile from "../Screens/MainScreen/Profile";
import Settings from "../Screens/MainScreen/Settings";
import Notification from "../Screens/MainScreen/Notification";
import AddSubscription from "../Screens/MainScreen/AddSubscription";

type BottomStackParamList = {
  HomeTab: undefined,
  WalletTab: undefined,
  ProfileTab: undefined,
};
type HomeStackParamList = {
  Home: undefined,
  Settings: undefined,
  Notification: undefined,
  AddSubscription: undefined,
};
type WalletStackParamList = {
  Wallet: undefined,
};
type ProfileStackParamList = {
  Profile: undefined,
};


const navigationRef = React.createRef<any>();

export function navigate(name: any, params: any) {
  navigationRef.current?.navigate(name, params);
}

const Tab = createBottomTabNavigator<BottomStackParamList>();
const HomeStack = createStackNavigator<HomeStackParamList>();
const WalletStack = createStackNavigator<WalletStackParamList>();
const ProfileStack = createStackNavigator<ProfileStackParamList>();



export const HomeStacks = () => {
  return (
    <HomeStack.Navigator initialRouteName="Home"
      screenOptions={{
        headerShown: false,
      }}>
      <HomeStack.Screen name="Home" component={Home} />
      <HomeStack.Screen name="Settings" component={Settings} />
      <HomeStack.Screen name="Notification" component={Notification} />
      <HomeStack.Screen name="AddSubscription" component={AddSubscription} />
      
    </HomeStack.Navigator>
  );
}

export const WalletStacks = () => {
  return (
    <WalletStack.Navigator initialRouteName="Wallet"
      screenOptions={{
        headerShown: false,
      }}>
      <WalletStack.Screen name="Wallet" component={Wallet} />



    </WalletStack.Navigator>
  );
}

const ProfileStacks = () => {
  return (
    <ProfileStack.Navigator initialRouteName="Profile"
      screenOptions={{
        headerShown: false,
      }}>
      <ProfileStack.Screen name="Profile" component={Profile} />

    </ProfileStack.Navigator>
  )
}





export const BottomTabView = (props: any) => {
  // let unreadChatCount = props?.chat?.unreadChatCount?.count ? props?.chat?.unreadChatCount?.count : 0
  let unreadChatCount = 1
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        headerShown: false,
        tabBarIcon: ({ focused }) => {
          let image;
          if (route.name === 'HomeTab') {
            image = focused ? Images.house_fill : Images.house;
          }
          else if (route.name === 'WalletTab') {
            image = focused ? Images.wallet_fill : Images.wallet;
          }
          else if (route.name === 'ProfileTab') {
            image = focused ? Images.person_fill : Images.person;
          }

          return (
            <>
              <View style={{ alignSelf: 'center', alignItems: 'center', justifyContent: 'center' }}>
                <Image source={image} style={{
                  marginTop: hp(2),
                  width: route.name === 'HomeTab' ? 34 : 32,
                  height: 32,
                }}
                />
              </View>
            </>
          );
        },
        tabBarStyle: {
          height: hp(10),
          backgroundColor: Colors.skyBlue,
          borderTopColor: Colors.skyBlue,
          justifyContent: 'center',
          alignItems: 'center'
        },
        tabBarShowLabel: false
      })}>

      <Tab.Screen name="HomeTab" component={HomeStacks} />
      <Tab.Screen name="WalletTab" component={WalletStacks} />

      <Tab.Screen name="ProfileTab" component={ProfileStacks} />

    </Tab.Navigator>
  );
}

export default BottomTabView;