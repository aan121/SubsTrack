import React from "react";
import { TouchableOpacity, Text, StyleSheet, Dimensions, View } from 'react-native';
import Colors from "../Styles/Colors";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp
} from 'react-native-responsive-screen';
import Ionic from 'react-native-vector-icons/Ionicons';


const widthScreen = Dimensions.get('window').width;


const Header = (props: any) => {
  const { navigation, screenName } = props

  return (

    <View style={Styles.headerContainer}>
      <TouchableOpacity onPress={() => { navigation.navigate("Settings") }}>
        <Ionic
          name={screenName == "Settings" ? "settings" : "settings-outline"}
          size={32}
          style={{
            color: Colors.White,
          }}
        />
      </TouchableOpacity>
      <Text style={Styles.headerText}>{`Substrack`}</Text>
      <TouchableOpacity onPress={() => { navigation.navigate("Notification") }}>
        <Ionic
          name={screenName == "Notification" ? "notifications" : "notifications-outline"}
          size={32}
          style={{
            color: Colors.White,
          }}
        />
      </TouchableOpacity>

    </View>
  )
}

const Styles = StyleSheet.create({

  headerContainer: {
    width: widthScreen / 1.12,
    alignSelf: "center",
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginTop: hp(2),
    marginBottom: hp(2)
  },

  headerText: {
    fontSize: 24,
    fontFamily: "Times New Roman",
    fontStyle: "italic",
    color: Colors.White,
  },
})
export default Header;