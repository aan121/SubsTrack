import React, { useState } from 'react';
import {
  SafeAreaView,
  StatusBar,
  View,
  Image,
  Text,
  TouchableOpacity,
  TextInput,
  Platform
} from 'react-native';
import Images from '../../../Styles/Images';
import Colors from '../../../Styles/Colors';
import Button from "../../../Components/Button";
import { KeyboardAwareScrollView } from 'react-native-keyboard-aware-scroll-view';
import Styles from './Styles';
import { LinearGradient } from 'expo-linear-gradient';


export type Props = {
  navigation: any;
};

const SignUp = (props: any) => {

  const [firstName, setFirstName] = useState("")
  const [lastName, setLastName] = useState("")
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [phone, setPhone] = useState("")
  const { navigation } = props;

  const onSubmit = () => {
    navigation.navigate("BottomNavigation", {
      screen: "HomeTab"
    })
  }

  const onCancel = () => {
    navigation.navigate("Login")
  }

  return (
    <LinearGradient colors={['#030930', '#68DCF5']}
      style={Styles.backgroundWrapper}>
      <SafeAreaView style={Styles.safeAreaContainer}>
        <StatusBar barStyle={'light-content'} />
        <KeyboardAwareScrollView showsVerticalScrollIndicator={false}
          enableOnAndroid={true} extraHeight={130} extraScrollHeight={130}
          enableAutomaticScroll={(Platform.OS === 'ios')}
          contentContainerStyle={Styles.safeAreaContainer}>
          <View style={Styles.mainContainer}>
            <View style={Styles.backgroundWrapper}>

              <View style={Styles.mainHeadContainer}>

                {/* Email */}
                <View style={Styles.wrapper}>
                  <TextInput style={Styles.textInput}
                    value={email}
                    placeholder={"Email Address"}
                    autoCapitalize="none"
                    placeholderTextColor={Colors.Black}
                    onChangeText={(value) => {
                      setEmail(value)
                    }}
                  />
                </View>

                {/* Password */}
                <View style={Styles.wrapper}>
                  <TextInput style={Styles.textInput}
                    value={password}
                    placeholder={"Password"}
                    placeholderTextColor={Colors.Black}
                    secureTextEntry={true}
                    autoCapitalize="none"
                    onChangeText={(value) => {
                      setPassword(value)
                    }}
                  />
                </View>

                {/* First Name */}
                <View style={Styles.wrapper}>
                  <TextInput style={Styles.textInput}
                    value={firstName}
                    placeholder={"First Name"}
                    autoCapitalize="none"
                    placeholderTextColor={Colors.Black}
                    onChangeText={(value) => {
                      setFirstName(value)
                    }}
                  />
                </View>

                 {/* Last Name */}
                 <View style={Styles.wrapper}>
                  <TextInput style={Styles.textInput}
                    value={lastName}
                    placeholder={"Last Name"}
                    autoCapitalize="none"
                    placeholderTextColor={Colors.Black}
                    onChangeText={(value) => {
                      setLastName(value)
                    }}
                  />
                </View>

                 {/* Phone Number */}
                 <View style={Styles.wrapper}>
                  <TextInput style={Styles.textInput}
                    value={phone}
                    placeholder={"Phone Number"}
                    autoCapitalize="none"
                    placeholderTextColor={Colors.Black}
                    keyboardType={"phone-pad"}
                    onChangeText={(value) => {
                      setPhone(value)
                    }}
                  />
                </View>

              </View>

              <View style={Styles.bottomHeadContainer}>

                <View style={Styles.buttonWrapper}>
                  <Button
                    goToOther={onSubmit}
                    buttontxt={"Sign Up"}
                    buttonColor={Colors.White}
                    textColor={Colors.Black} />
                </View>

              </View>

              <View style={Styles.bottomHeadContainer}>

                <View style={Styles.buttonWrapper}>
                  <Button
                    goToOther={onCancel}
                    buttontxt={"Cancel"}
                    buttonColor={Colors.Black}
                    textColor={Colors.White} />
                </View>

              </View>
            </View>

          </View>
        </KeyboardAwareScrollView>
      </SafeAreaView>
    </LinearGradient>
  );
}

export default SignUp;
