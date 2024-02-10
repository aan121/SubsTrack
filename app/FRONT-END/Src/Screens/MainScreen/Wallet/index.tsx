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
import { LinearGradient } from 'expo-linear-gradient';
import Header from "../../../Components/Header";
import BalanceSpend from "../../../Components/BalanceSpend";
import { useSubscriptionContext } from '../../../Components/SubscriptionContext'; // Import the SubscriptionContext
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';
import Colors from '../../../Styles/Colors';
import { LineChart } from 'react-native-chart-kit';
import ModalDropdown from 'react-native-modal-dropdown'; // Import the dropdown component

export type Props = {
  navigation: any;
};

const Wallet = (props: any) => {
  const { navigation } = props;
  const { subscriptions, deleteSubscription, getSubscriptionImage } = useSubscriptionContext(); // Use the SubscriptionContext

  const [selectedCategory, setSelectedCategory] = useState('All'); // State to manage selected category

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

  const categories = ['All', 'Entertainment', 'Health and Fitness', 'News and Magazines', 'Food and Meal Services', 'Utilities', 'Transportation', 'Shopping and Retail', 'Productivity and Software', 'Education', 'Financial', 'Streaming Music', 'Streaming Video', 'Home and Lifestyle', 'Gaming', 'Travel and Hospitality', 'Personal Care', 'Other'];

  // Sample data for the line chart
  const monthlySpendingData = [
    { month: 'Jan', amount: 600 },
    { month: 'Feb', amount: 800 },
    { month: 'Mar', amount: 400 },
    { month: 'Apr', amount: 300 },
    { month: 'May', amount: 600 },
    { month: 'Jun', amount: 900 },
    { month: 'Jul', amount: 400 },
    { month: 'Aug', amount: 300 },
    { month: 'Sep', amount: 800 },
    { month: 'Oct', amount: 700 },
    { month: 'Nov', amount: 300 },
    { month: 'Dec', amount: 600 },
    // Add data for each month of the year
  ];

  const chartHeight = monthlySpendingData.length * 40; // Adjust the multiplier as needed

  return (
    <SafeAreaView style={Styles.backgroundWrapper}>
      <StatusBar barStyle={'light-content'} />
      <View style={Styles.mainContainer}>
        <Header screenName={``} navigation={props.navigation} />
        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={Styles.scrollContent}>

            {/* Replace the BalanceSpend component with the LineChart */}
            
            <LinearGradient 
              colors={['#000000', 'rgba(0, 0, 0, 0.1)']} 
              style={[Styles.dataHeadWrap, { marginBottom: 20, borderRadius: 16, height: chartHeight }]} // Set the height dynamically
            >
              <LineChart
                data={{
                  labels: monthlySpendingData.map(data => data.month),
                  datasets: [{
                    data: monthlySpendingData.map(data => data.amount)
                  }]
                }}
                width={wp('100%')} // Adjust width to 100% to fill the container
                height={chartHeight} // Set the height dynamically
                yAxisLabel="$"
                chartConfig={{
                  backgroundColor: Colors.darkBlue,
                  backgroundGradientFrom: Colors.Black,
                  backgroundGradientTo: Colors.darkBlue,
                  decimalPlaces: 2,
                  color: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
                  style: {
                    borderRadius: 16
                  }
                }}
                bezier
                style={{
                  borderRadius: 16
                }}
              />
            </LinearGradient>

            {/* Rest of your content */}
            <View style={Styles.listHeader}>
              <ModalDropdown
                options={categories}
                onSelect={(index, value) => setSelectedCategory(value)}
                dropdownStyle={Styles.dropdownStyle} // Define dropdown styles
                textStyle={Styles.dropdownTextStyle} // Define text styles
              >
                <Image source={Images.cameraFilters} style={Styles.filterIcon} />
              </ModalDropdown>
            </View>

            <LinearGradient colors={['#000000', 'rgba(0, 0, 0, 0.1)']} style={Styles.dataHeadWrap}>
              <ScrollView showsVerticalScrollIndicator={false}>
                <View style={Styles.listInnerWrap}>
                  {subscriptions.filter(subscription => selectedCategory === 'All' || subscription.category === selectedCategory).map((item) => (
                    <TouchableOpacity
                      key={item.id}
                      onPress={() => showDeleteAlert(item)}
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


