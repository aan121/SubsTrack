import { StyleSheet, Dimensions } from 'react-native';
import Colors from '../../../Styles/Colors';

import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';

const widthScreen = Dimensions.get('window').width;
const heightScreen = Dimensions.get('window').height;

const styles = StyleSheet.create({
  backgroundContainer: {
    width: widthScreen,
    height: heightScreen,
  },
  safeAreaContainer: {
    // flex: 1
    flexGrow: 1,
  },
  mainContainer: {
    flex: 1,
  },
  backgroundWrapper: {
    flex: 1,
  },
  mainHeadContainer: {
    flex: 0.3,
    justifyContent: 'center',
    alignItems: 'center'
  },
  welcomeText: {
    fontSize: 40,
    fontFamily: "Outfit-Regular",
    textAlign: 'center',
    color: Colors.White,
    width: widthScreen / 1.12,
    alignSelf: 'center',
  },
  bottomHeadContainer: {
    width: widthScreen,
    flex: 0.5,
    justifyContent: 'center',
    alignItems: 'center'
  },
  wrapper: {
    width: widthScreen / 1.2,
    alignSelf: 'center',
    backgroundColor: Colors.White,
    height: hp(6),
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: "center",
    borderRadius: 15,
    borderWidth: 1,
    borderColor: Colors.White,
    marginBottom: hp(3),
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
    color: Colors.Black,
    marginLeft: hp(1.5),
  },
  userEmailAndroid: {
    flex: 1,
    fontFamily: "Outfit-Medium",
    fontSize: 15,
    color: Colors.Black,
    marginLeft: hp(1.5),
    includeFontPadding: false,
  },
  buttonWrapper: {
    marginTop: hp(2)
  },
  orText: {
    fontSize: 20,
    fontFamily: "Outfit-Regular",
    textAlign: 'center',
    color: Colors.White,
    marginTop: hp(2)
  }
});
export default styles;