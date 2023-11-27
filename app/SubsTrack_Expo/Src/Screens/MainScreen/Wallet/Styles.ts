import { StyleSheet, Dimensions } from 'react-native';
import Colors from '../../../Styles/Colors';

import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';

const widthScreen = Dimensions.get('window').width;
const heightScreen = Dimensions.get('window').height;

const styles = StyleSheet.create({
  backgroundWrapper: {
    flex: 1,
    backgroundColor: Colors.darkBlue
  },
  mainContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center"
  },

  logoText: {
    fontSize: 130,
    fontFamily: "Corinthia-Bold",
    color: Colors.White,
  },
  logoIcon: {
    width: 118,
    height: 90
  },
  scrollContent: {
    marginTop: hp(2),
    marginBottom: hp(5)
  },
  listHeader: {
    width: widthScreen / 1.12,
    alignSelf: "center",
    alignItems: "flex-end",
    marginTop: hp(5),
  },
  filterIcon: {
    width: 32,
    height: 32
  },
  dataHeadWrap: {
    width: widthScreen,
    alignSelf: "center",
    marginTop: hp(2),
    borderWidth: 1,
    borderColor: "#4ea3dd",
    borderRadius: 15,
    height: hp(50)
  },
  innerDataWrap: {
    width: '90%',
    alignSelf: "center",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    marginTop: hp(1.5),
    marginBottom: hp(1.5),
  },
  listInnerWrap: {
    marginBottom: hp(0.7),
  },
  itemWrapper: {
    width: '96%',
    alignSelf: "center",
    marginTop: hp(0.7),
    height: hp(17),
    borderRadius: 20,
    borderWidth: 1,
    borderColor: "#4ea3dd",
    justifyContent: "center",
    alignItems: "center"
  },
  subscriptionIcon: {
    width: 88,
    height: 60.62,
    alignSelf: "center"
  },
  subscriptionText: {
    fontSize: hp(2),
    fontFamily: "Poppins-Medium",
    color: Colors.White,
  },
  numberText: {
    fontSize: hp(2),
    fontFamily: "Poppins-SemiBold",
    color: Colors.White,
    // marginTop: 3,
    textAlign: "center"
  },
  entertainmentText: {
    fontSize: hp(2),
    fontFamily: "Poppins-SemiBold",
    color: Colors.White,
  },
  subscriptionPrice: {
    fontSize: hp(2),
    fontFamily: "Poppins-SemiBold",
    color: Colors.White,
  },
  monthText: {
    fontSize: hp(2),
    fontFamily: "Poppins-SemiBold",
    color: Colors.White,
  },


});
export default styles;