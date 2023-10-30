import React from "react";
import { TouchableOpacity, Text, StyleSheet, Dimensions } from 'react-native';
import Colors from "../Styles/Colors";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp
} from 'react-native-responsive-screen';

const widthScreen = Dimensions.get('window').width;


const Button = (props: any) => {
  const { buttonColor, buttontxt, goToOther, textColor } = props

  return (

    <TouchableOpacity style={[styles.touchBtn, { backgroundColor: buttonColor }]} onPress={goToOther}>
      <Text style={[styles.txtBtn, { color: textColor }]}>{buttontxt}</Text>
    </TouchableOpacity>
  )
}

const styles = StyleSheet.create({

  touchBtn: {
    width: widthScreen / 1.2,
    alignSelf: 'center',
    height: hp(6.4),
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 16,
  },
  txtBtn: {
    fontFamily: "Outfit-Bold",
    fontSize: 22,
  },
})
export default Button;