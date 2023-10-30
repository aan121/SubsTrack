import React, { useState } from 'react';
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
import Colors from '../../../Styles/Colors';
import Ionic from 'react-native-vector-icons/Ionicons';
import { LinearGradient } from 'expo-linear-gradient';
import Header from "../../../Components/Header";
import BalanceSpend from "../../../Components/BalanceSpend";

export type Props = {
  navigation: any;
};


const Home = (props: any) => {
  const { navigation } = props;
  const [search, setSearch] = useState("")


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
    },
    {
      id: "5",
      name: "Youtube"
    },
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

            {/* Subscriptions */}
            <View style={Styles.listHeader}>
              <Text style={Styles.substriptionText}>{`Subscriptions`}</Text>
              <TouchableOpacity onPress={() => { props.navigation.navigate("AddSubscription") }}>
                <Ionic
                  name="add-circle-outline"
                  size={32}
                  style={{
                    color: Colors.White,
                  }}
                />
              </TouchableOpacity>
            </View>

            <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']}
              style={Styles.dataHeadWrap}>
              <ScrollView horizontal={true} showsHorizontalScrollIndicator={false}>
                <View style={Styles.listInnerWrap}>
                  {
                    SUBSCRIPTION_CARDS?.map((item, keyID) => {
                      return (
                        <TouchableOpacity key={keyID}
                          onPress={() => { deleteSubscription(keyID) }}
                          style={Styles.itemWrapper}>
                          <Image source={Images.youtubeLogo} style={Styles.youtubeIcon} />
                          <Text style={Styles.youtubeText}>{`Youtube`}</Text>
                          <Text style={Styles.numberText}>{`27/10`}</Text>
                          <Text style={Styles.youtubePrice}>{`$ 199`}</Text>
                          <Text style={Styles.monthText}>{`Monthly`}</Text>
                        </TouchableOpacity>
                      )
                    })
                  }
                </View>
              </ScrollView>
            </LinearGradient>

            {/* Search */}
            <View style={Styles.listHeader}>
              <Text style={Styles.substriptionText}>{`Search`}</Text>

              <View style={Styles.wrapper}>
                <TextInput style={Styles.textInput}
                  value={search}
                  placeholder={"Search"}
                  autoCapitalize="none"
                  placeholderTextColor={"rgba(60, 60, 67, 0.6)"}
                  onChangeText={(value) => {
                    setSearch(value)
                  }}
                />
              </View>
            </View>

            <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']}
              style={Styles.dataHeadWrap}>
              <ScrollView horizontal={true} showsHorizontalScrollIndicator={false}>
                <View style={Styles.listInnerWrap}>
                  {
                    SUBSCRIPTION_CARDS?.map((item, keyID) => {
                      return (
                        <TouchableOpacity key={keyID}
                          onPress={() => { deleteSubscription(keyID) }}
                          style={Styles.itemWrapper}>
                          <Image source={Images.youtubeLogo} style={Styles.youtubeIcon} />
                          <Text style={Styles.youtubeText}>{`Youtube`}</Text>
                          <Text style={Styles.numberText}>{`27/10`}</Text>
                          <Text style={Styles.youtubePrice}>{`$ 199`}</Text>
                          <Text style={Styles.monthText}>{`Monthly`}</Text>
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

export default Home;