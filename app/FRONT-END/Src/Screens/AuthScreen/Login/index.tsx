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
import { FIREBASE_AUTH, signInWithEmailAndPassword, createUserWithEmailAndPassword } from '../../../../FirebaseConfig';


export type Props = {
  navigation: any;
};

const Login = (props: any) => {
  const { navigation } = props;

  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")

  const onSubmit = async () => {
    try {
      await signInWithEmailAndPassword(FIREBASE_AUTH, email, password);
      navigation.navigate("BottomNavigation", { screen: "HomeTab" });
    } catch (error) {
      console.error("Error signing in: ", error.message);
      // Handle authentication error
    }
  };

  const goToSignUp = () => {
    navigation.navigate("SignUp")
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
                <Text style={Styles.welcomeText}>{`Welcome to Substrack`}</Text>
              </View>
              <View style={Styles.bottomHeadContainer}>

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

                <View style={Styles.buttonWrapper}>
                  <Button
                    goToOther={onSubmit}
                    buttontxt={"Sign In"}
                    buttonColor={Colors.Black}
                    textColor={Colors.White} />
                </View>

                <Text style={Styles.orText}>{`or`}</Text>

                <View style={Styles.buttonWrapper}>
                  <Button
                    goToOther={goToSignUp}
                    buttontxt={"Sign Up"}
                    buttonColor={Colors.White}
                    textColor={Colors.Black} />
                </View>

              </View>
            </View>

          </View>
        </KeyboardAwareScrollView>
      </SafeAreaView>
    </LinearGradient>
  );
}

export default Login;