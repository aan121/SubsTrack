import React from "react";
import { TouchableOpacity, Text, StyleSheet, Dimensions, View } from 'react-native';
import Colors from "../Styles/Colors";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp
} from 'react-native-responsive-screen';
import { LinearGradient } from 'expo-linear-gradient';

const widthScreen = Dimensions.get('window').width;


const BalanceSpend = (props: any) => {
  const { amount } = props

  return (
    <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']}
      style={Styles.dataHeadWrap}>
      <View style={Styles.innerDataWrap}>
        <Text style={Styles.spendText}>{`Current spend this month`}</Text>
        <Text style={Styles.priceText}>{amount}</Text>
        <Text style={Styles.avgText}>{`$98 below avg. spend`}</Text>
      </View>
    </LinearGradient>

  )
}

const Styles = StyleSheet.create({
  dataHeadWrap: {
    width: widthScreen,
    alignSelf: "center",
    marginTop: hp(2),
    borderWidth: 1,
    borderColor: "#4ea3dd",
    borderRadius: 15
  },
  innerDataWrap: {
    width: '90%',
    alignSelf: "center",
    marginTop: hp(2),
    marginBottom: hp(2)
  },
  spendText: {
    fontSize: 20,
    fontFamily: "Times New Roman",
    color: Colors.White,
  },
  priceText: {
    fontSize: 40,
    fontFamily: "Times New Roman",
    color: Colors.White,
    fontWeight: "bold",
    marginTop: hp(1.5),
    marginBottom: hp(1.5)
  },
  avgText: {
    fontSize: 20,
    fontFamily: "Times New Roman",
    color: Colors.White,
  },
})
export default BalanceSpend;