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
    alignSelf: "center",
    marginTop: hp(0.7),
    height: hp(7.3),
    borderRadius: 30,
    borderWidth: 1,
    borderColor: "#4ea3dd",
    justifyContent: "center",
    alignItems: "center"
  },
  innerDataWrap: {
    width: '90%',
    alignSelf: "center",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
  },
  entertainmentText: {
    fontSize: hp(1.6),
    fontFamily: "Outfit-Bold",
    color: Colors.White,
  },
  youtubePrice: {
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