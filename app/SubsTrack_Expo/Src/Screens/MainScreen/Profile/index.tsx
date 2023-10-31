import React, { useState } from 'react';
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
import Colors from '../../../Styles/Colors';
import Images from '../../../Styles/Images';
import { LinearGradient } from 'expo-linear-gradient';
import Header from "../../../Components/Header";
import ToggleSwitch from 'toggle-switch-react-native';

export type Props = {
  navigation: any;
};

const Profile = (props: any) => {
  const { navigation } = props;
  const [firstName, setFirstName] = useState("")
  const [lastName, setLastName] = useState("")
  const [email, setEmail] = useState("")
  const [phone, setPhone] = useState("")
  const [notifyEmail, setNotifyEmail] = useState(true)
  const [sms, setSMS] = useState(false)


  return (
    <SafeAreaView style={Styles.backgroundWrapper}>
     <StatusBar barStyle={"light-content"} />
      <View style={Styles.mainContainer}>

        <Header
          screenName={``}
          navigation={props.navigation} />

        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={Styles.scrollContent}>

            {/* Email */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`Email`}</Text>

              <View style={Styles.emailWrapper}>
                <TextInput style={Styles.textInput}
                  value={email}
                  placeholder={"example@gmail.com"}
                  autoCapitalize="none"
                  editable={false}
                  placeholderTextColor={Colors.mediumBlack}
                  onChangeText={(value) => {
                    setEmail(value)
                  }}
                />
              </View>
            </View>

            {/* First Name */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`First Name`}</Text>

              <View style={Styles.wrapper}>
                <TextInput style={Styles.textInput}
                  value={firstName}
                  placeholder={"Abdulwahab"}
                  autoCapitalize="none"
                  placeholderTextColor={Colors.mediumBlack}
                  onChangeText={(value) => {
                    setFirstName(value)
                  }}
                />
              </View>
            </View>

            {/* Last Name */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`Last Name`}</Text>

              <View style={Styles.wrapper}>
                <TextInput style={Styles.textInput}
                  value={lastName}
                  placeholder={"Alnemer"}
                  autoCapitalize="none"
                  placeholderTextColor={Colors.mediumBlack}
                  onChangeText={(value) => {
                    setLastName(value)
                  }}
                />
              </View>
            </View>

            {/* Phone Number */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`Phone`}</Text>
              <View style={Styles.wrapper}>
                <TextInput style={Styles.textInput}
                  value={phone}
                  placeholder={"3213145439"}
                  autoCapitalize="none"
                  keyboardType={"phone-pad"}
                  placeholderTextColor={Colors.mediumBlack}
                  onChangeText={(value) => {
                    setPhone(value)
                  }}
                />
              </View>
            </View>


            <Text style={Styles.notificationHead}>{`Notifications`}</Text>

            <View style={Styles.itemWrapper}>
              <View>
                <Text style={Styles.toogleText}>{`Email`}</Text>
                <ToggleSwitch
                  isOn={notifyEmail}
                  onColor={Colors.skyBlue}
                  offColor="#E9E9EA"
                  size="small"
                  onToggle={isOn => setNotifyEmail(isOn)}
                />
              </View>

              <View>
                <Text style={Styles.toogleText}>{`SMS`}</Text>
                <ToggleSwitch
                  isOn={sms}
                  onColor={Colors.skyBlue}
                  offColor="#E9E9EA"
                  size="small"
                  onToggle={isOn => setSMS(isOn)}
                />
              </View>
            </View>

          </View>
        </ScrollView>

        <View style={Styles.buttonWrapper}>
          <TouchableOpacity style={Styles.touchBtn} onPress={() => { props.navigation.navigate("Home") }}>
            <Text style={Styles.txtBtn}>{"Cancel"}</Text>
          </TouchableOpacity>

          <TouchableOpacity style={Styles.touchBtn} onPress={() => { props.navigation.navigate("Home") }}>
            <Text style={Styles.txtBtn}>{"Save"}</Text>
          </TouchableOpacity>
        </View>

      </View>
    </SafeAreaView>
  );
}

export default Profile;