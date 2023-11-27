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
  logoIcon: {
    width: 118,
    height: 90
  },
  scrollContent: {
    marginTop: hp(2),
    marginBottom: hp(5)
  },
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
  listHeader: {
    width: widthScreen / 1.12,
    alignSelf: "center",
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginTop: hp(5),
  },
  listContainer: {
    width: widthScreen,
    alignSelf: "center",
    borderWidth: 1,
    borderColor: "#4ea3dd",
    borderRadius: 15,
    marginTop: hp(2),
  },
  substriptionText: {
    fontSize: 20,
    fontFamily: "Times New Roman",
    color: Colors.White,
    fontWeight: "bold",
  },
  listInnerWrap: {
    width: '96%',
    alignSelf: "center",
    marginTop: hp(1.5),
    marginBottom: hp(1.5),
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between"
  },
  itemWrapper: {
    width: hp(10),
    height: hp(17),
    borderRadius: 20,
    borderWidth: 1,
    borderColor: "#4ea3dd",
    justifyContent: "center",
    alignItems: "center",
    marginRight: hp(0.7),
    marginLeft: hp(0.7)
  },
  subscriptionIcon: {
    width: hp(4.5),
    height: hp(3.1),
    alignSelf: "center"
  },
  subscriptionText: {
    fontSize: hp(1.5),
    fontFamily: "Poppins-Medium",
    color: Colors.White,
    marginTop: 5,
    textAlign: "center"
  },
  numberText: {
    fontSize: hp(1.5),
    fontFamily: "Poppins-SemiBold",
    color: Colors.White,
    marginTop: 3,
    textAlign: "center"
  },
  subscriptionPrice: {
    fontSize: hp(1.7),
    fontFamily: "Poppins-SemiBold",
    color: Colors.White,
    marginTop: 3,
    textAlign: "center"
  },
  monthText: {
    fontSize: 8,
    fontFamily: "Poppins-SemiBold",
    color: Colors.White,
    marginTop: 3,
    textAlign: "center"
  },

  wrapper: {
    width: "70%",
    alignSelf: 'center',
    backgroundColor: Colors.White,
    height: hp(4.5),
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: "center",
    borderRadius: 15,
    borderWidth: 1,
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
    fontFamily: "Times New Roman",
    fontSize: 15,
    color: "rgba(60, 60, 67, 0.6)",
    marginLeft: hp(2),
    fontWeight: "500"
  },
  userEmailAndroid: {
    flex: 1,
    fontFamily: "Times New Roman",
    fontSize: 15,
    color: "rgba(60, 60, 67, 0.6)",
    marginLeft: hp(2),
    includeFontPadding: false,
    fontWeight: "500"
  },


});
export default styles;