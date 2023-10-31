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
  buttonWrapper: {
    marginBottom: hp(2)
  },

});
export default styles;