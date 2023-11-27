// Login/index.tsx

import React, { useState, useEffect } from 'react';
import { LinearGradient } from 'expo-linear-gradient';
import {
  SafeAreaView,
  StatusBar,
  View,
  Text,
  TouchableOpacity,
  TextInput,
  Platform,
} from 'react-native';
import {
  signInWithEmailAndPassword,
  getAuth,
  Auth,
  GoogleAuthProvider,
  signInWithPopup,
} from 'firebase/auth';
import { FIREBASE_AUTH, GOOGLE_PROVIDER } from '../../../../FirebaseConfig';
import Colors from '../../../Styles/Colors';
import Button from '../../../Components/Button';
import Styles from './Styles';

const Login = (props: any) => {
  const { navigation } = props;

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const onEmailSignIn = async () => {
    try {
      // Sign in with email and password
      await signInWithEmailAndPassword(FIREBASE_AUTH, email, password);

      // If successful, navigate to the HomeTab
      navigation.navigate('BottomNavigation', {
        screen: 'HomeTab',
      });
    } catch (error) {
      console.error('Error signing in:', error.message);
      // Handle authentication error (e.g., display an error message to the user)
    }
  };

  const onGoogleSignIn = async () => {
    try {
      // Sign in with Google using the popup method
      const result = await signInWithPopup(FIREBASE_AUTH, GOOGLE_PROVIDER);

      // If successful, navigate to the HomeTab
      navigation.navigate('BottomNavigation', {
        screen: 'HomeTab',
      });
    } catch (error) {
      console.error('Error signing in with Google:', error.message);
      // Handle authentication error (e.g., display an error message to the user)
    }
  };

  const goToSignUp = () => {
    navigation.navigate('SignUp');
  };

  return (
    <LinearGradient
      colors={['#030930', '#68DCF5']}
      style={Styles.backgroundWrapper}>
      <SafeAreaView style={Styles.safeAreaContainer}>
        <StatusBar barStyle={'light-content'} />
        <View style={Styles.mainContainer}>
          <View style={Styles.backgroundWrapper}>
            <View style={Styles.mainHeadContainer}>
              <Text style={Styles.welcomeText}>{`Welcome to Substrack`}</Text>
            </View>
            <View style={Styles.bottomHeadContainer}>
              <View style={Styles.wrapper}>
                <TextInput
                  style={Styles.textInput}
                  value={email}
                  placeholder={'Email Address'}
                  autoCapitalize="none"
                  placeholderTextColor={Colors.Black}
                  onChangeText={(value) => setEmail(value)}
                />
              </View>
              <View style={Styles.wrapper}>
                <TextInput
                  style={Styles.textInput}
                  value={password}
                  placeholder={'Password'}
                  placeholderTextColor={Colors.Black}
                  secureTextEntry={true}
                  autoCapitalize="none"
                  onChangeText={(value) => setPassword(value)}
                />
              </View>
              <View style={Styles.buttonWrapper}>
                <Button
                  goToOther={onEmailSignIn}
                  buttontxt={'Sign In with Email'}
                  buttonColor={Colors.Black}
                  textColor={Colors.White}
                />
              </View>
              <View style={Styles.orTextContainer}>
                <Text style={Styles.orText}>{`or`}</Text>
              </View>
              <TouchableOpacity
                style={Styles.googleSignInButton}
                onPress={onGoogleSignIn}>
                <Text style={Styles.googleSignInText}>{`Sign In with Google`}</Text>
              </TouchableOpacity>
              <View style={Styles.buttonWrapper}>
                <Button
                  goToOther={goToSignUp}
                  buttontxt={'Sign Up'}
                  buttonColor={Colors.White}
                  textColor={Colors.Black}
                />
              </View>
            </View>
          </View>
        </View>
      </SafeAreaView>
    </LinearGradient>
  );
};

export default Login;
