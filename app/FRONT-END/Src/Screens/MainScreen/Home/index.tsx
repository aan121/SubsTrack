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
import { useSubscriptionContext } from '../../../Components/SubscriptionContext'; // Import the SubscriptionContext

export type Props = {
  navigation: any;
};


const Home = (props: any) => {
  const { navigation } = props;
  const [search, setSearch] = useState("")
  const { subscriptions, deleteSubscription, getSubscriptionImage } = useSubscriptionContext(); // Use the SubscriptionContext



  const showDeleteAlert = (subscription) => {
    Alert.alert(
      'Delete Subscription',
      `Are you sure you want to delete the "${subscription.name}" subscription?`,
      [
        {
          text: 'Cancel',
          onPress: () => console.log('Cancel Pressed'),
          style: 'cancel',
        },
        {
          text: 'Delete',
          onPress: () => {
            deleteSubscription(subscription.id);
          },
        },
      ],
    );
  };

  // Filter subscriptions based on the search term
  const filteredSubscriptions = subscriptions.filter((item) =>
    item.name.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <SafeAreaView style={Styles.backgroundWrapper}>
      <StatusBar barStyle={'light-content'} />
      <View style={Styles.mainContainer}>
        <Header screenName={``} navigation={props.navigation} />
        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={Styles.scrollContent}>
            <BalanceSpend amount={`$1,120`} />

            {/* Subscriptions */}
            <View style={Styles.listHeader}>
              <Text style={Styles.substriptionText}>{`Subscriptions`}</Text>
              <TouchableOpacity onPress={() => { props.navigation.navigate('AddSubscription') }}>
                <Ionic
                  name="add-circle-outline"
                  size={32}
                  style={{
                    color: Colors.White,
                  }}
                />
              </TouchableOpacity>
            </View>

            <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']} style={Styles.dataHeadWrap}>
              <ScrollView horizontal={true} showsHorizontalScrollIndicator={false}>
                <View style={Styles.listInnerWrap}>
                  {subscriptions.map((item) => (
                    <TouchableOpacity
                      key={item.id}
                      onPress={() => showDeleteAlert(item)}
                      style={Styles.itemWrapper}
                    >
                      <Image source={getSubscriptionImage(item.name)} style={Styles.subscriptionIcon} />
                      <Text style={Styles.subscriptionText}>{item.name}</Text>
                      <Text style={Styles.numberText}>{item.billingDate}</Text>
                      <Text style={Styles.subscriptionPrice}>{`$ ${item.cost}`}</Text>
                      <Text style={Styles.monthText}>{item.cycle}</Text>
                    </TouchableOpacity>
                  ))}
                </View>
              </ScrollView>
            </LinearGradient>

            {/* Search */}
            <View style={Styles.listHeader}>
              <Text style={Styles.substriptionText}>{`Search`}</Text>
              <View style={Styles.wrapper}>
                <TextInput
                  style={Styles.textInput}
                  placeholder={'Search'}
                  value={search}
                  onChangeText={(value) => setSearch(value)}
                />
              </View>
            </View>

            <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']} style={Styles.dataHeadWrap}>
              <ScrollView horizontal={true} showsHorizontalScrollIndicator={false}>
                <View style={Styles.listInnerWrap}>
                  {filteredSubscriptions.map((item) => (
                    <TouchableOpacity
                      key={item.id}
                      onPress={() => showDeleteAlert(item)}
                      style={Styles.itemWrapper}
                    >
                      <Image source={getSubscriptionImage(item.name)} style={Styles.subscriptionIcon} />
                      <Text style={Styles.subscriptionText}>{item.name}</Text>
                      <Text style={Styles.numberText}>{item.billingDate}</Text>
                      <Text style={Styles.subscriptionPrice}>{`$ ${item.cost}`}</Text>
                      <Text style={Styles.monthText}>{item.cycle}</Text>
                    </TouchableOpacity>
                  ))}
                </View>
              </ScrollView>
            </LinearGradient>
          </View>
        </ScrollView>
      </View>
    </SafeAreaView>
  );
};

export default Home;