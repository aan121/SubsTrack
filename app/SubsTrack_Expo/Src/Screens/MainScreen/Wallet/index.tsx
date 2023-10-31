import React, { useEffect } from 'react';
import {
  SafeAreaView,
  StatusBar,
  View,
  Image,
  Text,
  TouchableOpacity,
  TextInput,
  Platform,
  ScrollView,
  Alert
} from 'react-native';
import Styles from './Styles';
import Images from '../../../Styles/Images';
import { LinearGradient } from 'expo-linear-gradient';
import Header from "../../../Components/Header";
import BalanceSpend from "../../../Components/BalanceSpend";


export type Props = {
  navigation: any;
};


const Wallet = (props: any) => {
  const { navigation } = props;
  const SUBSCRIPTION_CARDS = [
    {
      id: "1",
      name: "Youtube"
    },
    {
      id: "2",
      name: "Youtube"
    },
    {
      id: "3",
      name: "Youtube"
    },
    {
      id: "4",
      name: "Youtube"
    }
  ]

  const deleteSubscription = (num: any) => {
    Alert.alert('', 'Are you sure you want to delete this subscription?', [
      {
        text: 'Cancel',
        onPress: () => console.log('Cancel Pressed'),
        style: 'cancel',
      },
      { text: 'Delete', onPress: () => console.log('OK Pressed') },
    ]);

  }


  return (
    <SafeAreaView style={Styles.backgroundWrapper}>
      <StatusBar barStyle={"light-content"} />
      <View style={Styles.mainContainer}>

        <Header
          screenName={``}
          navigation={props.navigation} />

        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={Styles.scrollContent}>

            <BalanceSpend amount={`$1,120`} />

            {/* cameraFilters */}
            <View style={Styles.listHeader}>
              <TouchableOpacity>
                <Image source={Images.cameraFilters} style={Styles.filterIcon} />
              </TouchableOpacity>
            </View>

            <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']}
              style={Styles.dataHeadWrap}>
              <ScrollView showsVerticalScrollIndicator={false}>
                <View style={Styles.listInnerWrap}>
                  {
                    SUBSCRIPTION_CARDS?.map((item, keyID) => {
                      return (
                        <TouchableOpacity key={keyID}
                          onPress={() => { deleteSubscription(keyID) }}
                          style={Styles.itemWrapper}>
                          <View style={Styles.innerDataWrap}>
                            <Image source={Images.youtubeLogo} style={Styles.youtubeIcon} />
                            <View>
                              <Text style={Styles.youtubeText}>{`Youtube`}</Text>
                              <Text style={Styles.numberText}>{`27/10`}</Text>
                            </View>
                            <View>
                              <Text style={Styles.entertainmentText}>{`Entertainment`}</Text>
                              <Text style={Styles.youtubePrice}>{`$ 199`}</Text>
                              <Text style={Styles.monthText}>{`Monthly`}</Text>
                            </View>
                          </View>
                        </TouchableOpacity>
                      )
                    })
                  }
                </View>
              </ScrollView>
            </LinearGradient>

          </View>
        </ScrollView>

      </View>
    </SafeAreaView>
  );
}

export default Wallet;