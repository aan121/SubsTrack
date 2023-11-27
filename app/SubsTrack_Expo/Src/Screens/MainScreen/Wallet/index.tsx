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
import { useSubscriptionContext } from '../../../Components/SubscriptionContext'; // Import the SubscriptionContext


export type Props = {
  navigation: any;
};


const Wallet = (props: any) => {
  const { navigation } = props;
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
      ]
    );
  };


  return (
    <SafeAreaView style={Styles.backgroundWrapper}>
      <StatusBar barStyle={'light-content'} />
      <View style={Styles.mainContainer}>
        <Header screenName={``} navigation={props.navigation} />
        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={Styles.scrollContent}>
            <BalanceSpend amount={`$1,120`} />

            {/* cameraFilters */}
            <View style={Styles.listHeader}>
              <TouchableOpacity>
                <Image source={Images.cameraFilters} style={Styles.filterIcon} />
              </TouchableOpacity>
            </View>

            <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']} style={Styles.dataHeadWrap}>
              <ScrollView showsVerticalScrollIndicator={false}>
                <View style={Styles.listInnerWrap}>
                  {subscriptions.map((item) => (
                    <TouchableOpacity
                      key={item.id}
                      onPress={() => showDeleteAlert(item)} // Show the delete alert
                      style={Styles.itemWrapper}
                    >
                      <View style={Styles.innerDataWrap}>
                       <Image source={getSubscriptionImage(item.name)} style={Styles.subscriptionIcon} />
                        <View>
                          <Text style={Styles.subscriptionText}>{item.name}</Text>
                          <Text style={Styles.numberText}>{item.billingDate}</Text>
                        </View>
                        <View>
                          <Text style={Styles.entertainmentText}>{item.category}</Text>
                          <Text style={Styles.subscriptionPrice}>{`$ ${item.cost}`}</Text>
                          <Text style={Styles.monthText}>{item.cycle}</Text>
                        </View>
                      </View>
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

export default Wallet;