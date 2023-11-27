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
  itemWrapper: {
    width: widthScreen / 1.12,
    marginTop: hp(2.5),
    // alignItems: "center"
  },
  inputHeader: {
    fontSize: 20,
    fontFamily: "Times New Roman",
    color: Colors.White,
    fontWeight: "bold"
  },
  emailWrapper: {
    width: widthScreen / 1.7,
    // alignSelf: 'center',
    backgroundColor: Colors.mediumGrey,
    height: hp(5.5),
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: "center",
    borderRadius: 8,
    borderWidth: 1,
    marginTop: hp(1),
    borderColor: "#C0C0C0",
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.22,
    shadowRadius: 2.22,

    elevation: 3,
  },
  wrapper: {
    width: widthScreen / 1.4,
    // alignSelf: 'center',
    backgroundColor: Colors.White,
    height: hp(5.5),
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: "center",
    borderRadius: 8,
    borderWidth: 1,
    marginTop: hp(1),
    borderColor: Colors.White,
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.22,
    shadowRadius: 2.22,

    elevation: 3,
  },
  textInput: {
    flex: 1,
    fontFamily: "Outfit-Medium",
    fontSize: 15,
    color: Colors.mediumBlack,
    marginLeft: hp(1.5),
  },
  userEmailAndroid: {
    flex: 1,
    fontFamily: "Outfit-Medium",
    fontSize: 15,
    color: Colors.mediumBlack,
    marginLeft: hp(1.5),
    includeFontPadding: false,
  },
  notificationHead: {
    fontSize: 24,
    fontFamily: "Times New Roman",
    color: Colors.White,
    fontWeight: "bold",
    textAlign: "center",
    marginTop: hp(4)
  },
  toogleText: {
    fontSize: 20,
    fontFamily: "Times New Roman",
    color: Colors.White,
    fontWeight: "bold",
    marginBottom: hp(2)
  },
  buttonWrapper: {
    width: widthScreen / 1.12,
    alignSelf: "center",
    marginBottom: hp(3),
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: "center",
  },
  touchBtn: {
    width: 154,
    alignSelf: 'center',
    height: 52,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 16,
    backgroundColor: Colors.skyBlue
  },
  txtBtn: {
    fontFamily: "Outfit-Bold",
    fontSize: 22,
    color: Colors.White
  },
  dropdown: {
    width: widthScreen / 1.4,
    backgroundColor: Colors.White,
    height: hp(5.5),
    // justifyContent: 'space-between',
    alignItems: 'center',
    borderRadius: 8,
    borderWidth: 1,
    marginTop: hp(1),
    borderColor: Colors.White,
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.22,
    shadowRadius: 2.22,

    elevation: 3,
  },

  dropdownCycle: {
    width: 125,
    backgroundColor: Colors.White,
    height: hp(5.5),
    // justifyContent: 'space-between',
    alignItems: 'center',
    borderRadius: 8,
    borderWidth: 1,
    marginTop: hp(1),
    borderColor: Colors.White,
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.22,
    shadowRadius: 2.22,

    elevation: 3,
  },
  placeholderStyle: {
    fontFamily: "Outfit-Medium",
    fontSize: 15,
    color: Colors.mediumBlack,
    marginLeft: hp(1.5),
  },
  selectedTextStyle: {
    fontFamily: "Outfit-Medium",
    fontSize: 15,
    color: Colors.mediumBlack,
    marginLeft: hp(1.5),
  },
  iconStyle: {
    width: hp(2),
    height: hp(2),
    // tintColor: Colors.White,
    marginRight: hp(1.5)
  },
  billingWrapper: {
    flexDirection: "row",
    alignItems: "center"
  },
  dropdownBilling: {
    width: 110,
    marginRight: hp(2),
    backgroundColor: Colors.White,
    height: hp(5.5),
    // justifyContent: 'space-between',
    alignItems: 'center',
    borderRadius: 8,
    borderWidth: 1,
    marginTop: hp(1),
    borderColor: Colors.White,
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.22,
    shadowRadius: 2.22,

    elevation: 3,
  },
});
export default styles;