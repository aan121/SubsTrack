import React, { useEffect } from 'react';
import {
  View,
  Image,
  Text,
  ImageBackground,
  StatusBar,
  SafeAreaView
} from 'react-native';
import Styles from './Styles';
import Images from '../../Styles/Images';
import { LinearGradient } from 'expo-linear-gradient';

export type Props = {
  navigation: any;
};


const Splash = (props: any) => {
  const { navigation } = props;

  useEffect(() => {
    const timer = setTimeout(() => {
      navigation.navigate("Login")
    }, 3000);
    return () => clearTimeout(timer);
  }, []);


  return (
    <LinearGradient colors={['#030930', '#68DCF5']}
      style={Styles.backgroundWrapper}>
      <SafeAreaView style={Styles.backgroundWrapper}>
       <StatusBar barStyle={"light-content"} />
        <View style={Styles.mainContainer}>

          <Image source={Images.logo} style={Styles.logoIcon}/>
          {/* <Text style={Styles.logoText}>{"S"}</Text> */}

        </View>
      </SafeAreaView>
    </LinearGradient>
  );
}

export default Splash;