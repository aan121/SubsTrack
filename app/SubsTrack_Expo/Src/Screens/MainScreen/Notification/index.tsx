import React, { useEffect } from 'react';
import {
  SafeAreaView,
  StatusBar,
  View,
  Image,
  Text,
  TouchableOpacity,
  TextInput,
  Platform,
  ScrollView
} from 'react-native';
import Styles from './Styles';
import Images from '../../../Styles/Images';
import { LinearGradient } from 'expo-linear-gradient';
import Header from "../../../Components/Header";


export type Props = {
  navigation: any;
};


const Notification = (props: any) => {
  const { navigation } = props;

  const NOTIFICATIONS_CARDS = [
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
    {
      title: "Your Netflix Subscription is due in 3 days",
      time: "3d"
    },
  ]

  return (
    <SafeAreaView style={Styles.backgroundWrapper}>
     <StatusBar barStyle={"light-content"} />
      <View style={Styles.mainContainer}>

        <Header
          screenName={`Notification`}
          navigation={props.navigation} />

        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={Styles.scrollContent}>

            {
              NOTIFICATIONS_CARDS?.map((item, keyID) => {
                return (
                  <TouchableOpacity key={keyID}>
                    <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']}
                      style={Styles.itemWrapper}>
                      <View style={Styles.innerDataWrap}>
                        <Text style={Styles.entertainmentText}>{item?.title}</Text>
                        <Text style={Styles.entertainmentText}>{item?.time}</Text>
                      </View>
                    </LinearGradient>
                  </TouchableOpacity>
                )
              })
            }

          </View>
        </ScrollView>

      </View>
    </SafeAreaView>
  );
}

export default Notification;