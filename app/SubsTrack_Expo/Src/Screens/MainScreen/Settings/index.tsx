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
import Colors from '../../../Styles/Colors';
import Button from "../../../Components/Button";
import Header from "../../../Components/Header";

export type Props = {
  navigation: any;
};


const Settings = (props: any) => {
  const { navigation } = props;

  const onSubmit = () => {
    navigation.navigate("Login")
  }

  return (
    <SafeAreaView style={Styles.backgroundWrapper}>
     <StatusBar barStyle={"light-content"} />
      <View style={Styles.mainContainer}>

        <Header
          screenName={`Settings`}
          navigation={props.navigation} />

        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={Styles.scrollContent}>
          </View>
        </ScrollView>

        <View style={Styles.buttonWrapper}>
          <Button
            goToOther={onSubmit}
            buttontxt={"Sign Out"}
            buttonColor={Colors.skyBlue}
            textColor={Colors.White} />
        </View>

      </View>
    </SafeAreaView>
  );
}

export default Settings;