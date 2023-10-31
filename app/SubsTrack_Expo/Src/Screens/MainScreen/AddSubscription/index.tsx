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
  ScrollView
} from 'react-native';
import Styles from './Styles';
import Colors from '../../../Styles/Colors';
import Images from '../../../Styles/Images';
import { LinearGradient } from 'expo-linear-gradient';
import Header from "../../../Components/Header";
import ToggleSwitch from 'toggle-switch-react-native';
import { Dropdown } from 'react-native-element-dropdown';
import { useSubscriptionContext } from '../../../Components/SubscriptionContext'; // Import the SubscriptionContext

export type Props = {
  navigation: any;
};

const AddSubscription = (props: any) => {
  const { navigation } = props;
  const [number, setNumber] = useState("")
  const [day, setDay] = useState("")
  const [month, setMonth] = useState("")
  const [subscription, setSubscription] = useState("")
  const [category, setCategory] = useState("")
  const [cycle, setCycle] = useState("")

  const [isFocusState, setIsFocusState] = useState(false);
  const [isFocusCycle, setIsFocusCycle] = useState(false);
  const { addSubscription } = useSubscriptionContext(); // Use the SubscriptionContext


  const CYCLE = [
    {
      label: "Weekly",
      value: "Weekly",
    },
    {
      label: 'Monthly',
      value: 'Monthly'
    },
    {
      label: '3-Months',
      value: '3-Months'
    },
    {
      label: "6-Months",
      value: "6-Months",
    },
    {
      label: "Yearly",
      value: "Yearly",
    },
  ]
  const CATEGORY = [
    {
      label: "Entertainment",
      value: "Entertainment",
    },
    {
      label: 'Health and Fitness',
      value: 'Health and Fitness'
    },
    {
      label: 'News and Magazines',
      value: 'News and Magazines'
    },
    {
      label: "Food and Meal Services",
      value: "Food and Meal Services",
    },
    {
      label: "Utilities",
      value: "Utilities",
    },
    {
      label: "Transportation",
      value: "Transportation",
    },
    {
      label: "Shopping and Retail",
      value: "Shopping and Retail",
    },
    {
      label: "Productivity and Software",
      value: "Productivity and Software",
    },
    {
      label: "Education",
      value: "Education",
    },
    {
      label: "Financial",
      value: "Financial",
    },
    {
      label: "Streaming Music",
      value: "Streaming Music",
    },
    {
      label: "Streaming Video",
      value: "Streaming Video",
    },
    {
      label: "Home and Lifestyle",
      value: "Home and Lifestyle",
    },
    {
      label: "Gaming",
      value: "Gaming",
    },
    {
      label: "Travel and Hospitality",
      value: "Travel and Hospitality",
    },
    {
      label: "Personal Care",
      value: "Personal Care",
    },
    {
      label: "Other",
      value: "Other",
    },
  ]
  const DAY = [
    {
      label: "1",
      value: "1",
    },
    {
      label: "2",
      value: "2",
    },
    {
      label: "3",
      value: "3",
    },
    {
      label: "4",
      value: "4",
    },
    {
      label: "5",
      value: "5",
    },
    {
      label: "6",
      value: "6",
    },
    {
      label: "7",
      value: "7",
    },
    {
      label: "8",
      value: "8",
    },
    {
      label: "9",
      value: "9",
    },
    {
      label: "10",
      value: "10",
    },
    {
      label: "11",
      value: "11",
    },
    {
      label: "12",
      value: "12",
    },
    {
      label: "13",
      value: "13",
    },
    {
      label: "14",
      value: "14",
    },
    {
      label: "15",
      value: "15",
    },
    {
      label: "16",
      value: "16",
    },
    {
      label: "17",
      value: "17",
    },
    {
      label: "18",
      value: "18",
    },
    {
      label: "19",
      value: "19",
    },
    {
      label: "20",
      value: "20",
    },
    {
      label: "21",
      value: "21",
    },
    {
      label: "22",
      value: "22",
    },
    {
      label: "23",
      value: "23",
    },
    {
      label: "24",
      value: "24",
    },
    {
      label: "25",
      value: "25",
    },
    {
      label: "26",
      value: "26",
    },
    {
      label: "27",
      value: "27",
    },
    {
      label: "28",
      value: "28",
    },
    {
      label: "29",
      value: "29",
    },
    {
      label: "30",
      value: "30",
    },
    {
      label: "31",
      value: "31",
    },
  ]
  const MONTH = [
    {
      label: "1",
      value: "1",
    },
    {
      label: "2",
      value: "2",
    },
    {
      label: "3",
      value: "3",
    },
    {
      label: "4",
      value: "4",
    },
    {
      label: "5",
      value: "5",
    },
    {
      label: "6",
      value: "6",
    },
    {
      label: "7",
      value: "7",
    },
    {
      label: "8",
      value: "8",
    },
    {
      label: "9",
      value: "9",
    },
    {
      label: "10",
      value: "10",
    },
    {
      label: "11",
      value: "11",
    },
    {
      label: "12",
      value: "12",
    },
  ]

  const handleConfirm = () => {
    // Validate and add the subscription
    if (!subscription || !category || !cycle || !day || !month || !number) {
      // Handle validation error, show a message or alert
      return;
    }

    const newSubscription = {
      id: String(Math.random()), // Generate a unique ID (you should use a proper ID generation method)
      name: subscription,
      cost: number,
      billingDate: `${day}/${month}`,
      cycle: cycle,
      category: category,
    };

    addSubscription(newSubscription); // Add the subscription
    props.navigation.navigate('Home');
  };



  return (
    <SafeAreaView style={Styles.backgroundWrapper}>
      <StatusBar barStyle={'light-content'} />
      <View style={Styles.mainContainer}>
        <Header screenName={``} navigation={props.navigation} />
        <ScrollView showsVerticalScrollIndicator={false}>
          <View style={Styles.scrollContent}>
            {/* Subscription */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`Subscription`}</Text>
              <View style={Styles.wrapper}>
                <TextInput
                  style={Styles.textInput}
                  value={subscription}
                  placeholder={'Name'}
                  autoCapitalize="none"
                  editable={true}
                  placeholderTextColor={Colors.mediumBlack}
                  onChangeText={(value) => {
                    setSubscription(value);
                  }}
                />
              </View>
            </View>

            {/* Billing Date */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`Billing Date`}</Text>
              <View style={Styles.billingWrapper}>
                {/* Day */}
                <Dropdown
                  style={Styles.dropdownBilling}
                  placeholderStyle={Styles.placeholderStyle}
                  selectedTextStyle={Styles.selectedTextStyle}
                  iconStyle={Styles.iconStyle}
                  data={DAY}
                  maxHeight={500}
                  dropdownPosition={'bottom'}
                  labelField="label"
                  valueField="value"
                  placeholder={'Day'}
                  searchPlaceholder="Search"
                  value={day}
                  onChange={(item) => {
                    setDay(item.value);
                  }}
                />
                {/* Month */}
                <Dropdown
                  style={Styles.dropdownBilling}
                  placeholderStyle={Styles.placeholderStyle}
                  selectedTextStyle={Styles.selectedTextStyle}
                  iconStyle={Styles.iconStyle}
                  data={MONTH}
                  maxHeight={500}
                  dropdownPosition={'bottom'}
                  labelField="label"
                  valueField="value"
                  placeholder={'Month'}
                  searchPlaceholder="Search"
                  value={month}
                  onChange={(item) => {
                    setMonth(item.value);
                  }}
                />
              </View>
            </View>

            {/* Cost */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`Cost`}</Text>
              <View style={Styles.wrapper}>
                <TextInput
                  style={Styles.textInput}
                  value={number}
                  placeholder={'Number'}
                  autoCapitalize="none"
                  placeholderTextColor={Colors.mediumBlack}
                  keyboardType={'phone-pad'}
                  onChangeText={(value) => {
                    setNumber(value);
                  }}
                />
              </View>
            </View>

            {/* Billing Cycle */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`Billing Cycle`}</Text>
              <Dropdown
                style={Styles.dropdownCycle}
                placeholderStyle={Styles.placeholderStyle}
                selectedTextStyle={Styles.selectedTextStyle}
                iconStyle={Styles.iconStyle}
                data={CYCLE}
                maxHeight={500}
                dropdownPosition={'bottom'}
                labelField="label"
                valueField="value"
                placeholder={'Cycle'}
                searchPlaceholder="Search"
                value={cycle}
                onFocus={() => setIsFocusCycle(true)}
                onBlur={() => setIsFocusCycle(false)}
                onChange={(item) => {
                  setCycle(item.value);
                }}
              />
            </View>

            {/* Category */}
            <View style={Styles.itemWrapper}>
              <Text style={Styles.inputHeader}>{`Category`}</Text>
              <Dropdown
                style={Styles.dropdown}
                placeholderStyle={Styles.placeholderStyle}
                selectedTextStyle={Styles.selectedTextStyle}
                iconStyle={Styles.iconStyle}
                data={CATEGORY}
                maxHeight={500}
                dropdownPosition={'bottom'}
                labelField="label"
                valueField="value"
                placeholder={'Category'}
                searchPlaceholder="Search"
                value={category}
                onFocus={() => setIsFocusState(true)}
                onBlur={() => setIsFocusState(false)}
                onChange={(item) => {
                  setCategory(item.value);
                }}
              />
            </View>
          </View>
        </ScrollView>
        <View style={Styles.buttonWrapper}>
          <TouchableOpacity style={Styles.touchBtn} onPress={() => { props.navigation.navigate('Home') }}>
            <Text style={Styles.txtBtn}>{"Cancel"}</Text>
          </TouchableOpacity>
          <TouchableOpacity style={Styles.touchBtn} onPress={handleConfirm}>
            <Text style={Styles.txtBtn}>{"Confirm"}</Text>
          </TouchableOpacity>
        </View>
      </View>
    </SafeAreaView>
  );
};

export default AddSubscription;