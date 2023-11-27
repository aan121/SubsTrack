// SignUp/index.tsx

import React, { useState } from 'react';
import { FIREBASE_AUTH, createUserWithEmailAndPassword } from '../../../../FirebaseConfig';

import {
  SafeAreaView,
  StatusBar,
  View,
  TextInput,
  Platform,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import Colors from '../../../Styles/Colors';
import Button from '../../../Components/Button';
import { KeyboardAwareScrollView } from 'react-native-keyboard-aware-scroll-view';
import Styles from './Styles';

const SignUp = ({ navigation }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSignUp = async () => {
    try {
      const userCredential = await createUserWithEmailAndPassword(FIREBASE_AUTH, email, password);

      // You can add additional logic here if needed

      navigation.navigate('BottomNavigation', {
        screen: 'HomeTab',
      });
    } catch (error) {
      console.error('Error signing up:', error.message);
      // Handle error (show an alert, log, etc.)
    }
  };

  const onCancel = () => {
    navigation.navigate('Login');
  };

  return (
    <LinearGradient colors={['#030930', '#68DCF5']} style={Styles.backgroundWrapper}>
      <SafeAreaView style={Styles.safeAreaContainer}>
        <StatusBar barStyle="light-content" />
        <KeyboardAwareScrollView
          showsVerticalScrollIndicator={false}
          enableOnAndroid={true}
          extraHeight={130}
          extraScrollHeight={130}
          enableAutomaticScroll={Platform.OS === 'ios'}
          contentContainerStyle={Styles.safeAreaContainer}>
          <View style={Styles.mainContainer}>
            <View style={Styles.backgroundWrapper}>
              <View style={Styles.mainHeadContainer}>
                {/* Email */}
                <View style={Styles.wrapper}>
                  <TextInput
                    style={Styles.textInput}
                    value={email}
                    placeholder={'Email Address'}
                    autoCapitalize="none"
                    placeholderTextColor={Colors.Black}
                    onChangeText={(value) => {
                      setEmail(value);
                    }}
                  />
                </View>

                {/* Password */}
                <View style={Styles.wrapper}>
                  <TextInput
                    style={Styles.textInput}
                    value={password}
                    placeholder={'Password'}
                    placeholderTextColor={Colors.Black}
                    secureTextEntry={true}
                    autoCapitalize="none"
                    onChangeText={(value) => {
                      setPassword(value);
                    }}
                  />
                </View>
              </View>

              <View style={Styles.bottomHeadContainer}>
                <View style={Styles.buttonWrapper}>
                  <Button
                    goToOther={handleSignUp}
                    buttontxt={'Sign Up'}
                    buttonColor={Colors.White}
                    textColor={Colors.Black}
                  />
                </View>
              </View>

              <View style={Styles.bottomHeadContainer}>
                <View style={Styles.buttonWrapper}>
                  <Button
                    goToOther={onCancel}
                    buttontxt={'Cancel'}
                    buttonColor={Colors.Black}
                    textColor={Colors.White}
                  />
                </View>
              </View>
            </View>
          </View>
        </KeyboardAwareScrollView>
      </SafeAreaView>
    </LinearGradient>
  );
};

export default SignUp;
