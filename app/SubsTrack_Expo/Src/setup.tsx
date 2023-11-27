import React, { useCallback } from 'react';
import { View, LogBox } from 'react-native';
import { useFonts } from "expo-font";
import * as SplashScreen from 'expo-splash-screen';
import RootNavigation from "./Navigation/AppNavigation";

LogBox.ignoreAllLogs()

export default function Root() {
  const [isLoaded] = useFonts({
    "Corinthia-Bold": require("./Assets/Fonts/Corinthia-Bold.ttf"),
    "Corinthia-Regular": require("./Assets/Fonts/Corinthia-Regular.ttf"),
    "Outfit-Bold": require("./Assets/Fonts/Outfit-Bold.ttf"),
    "Outfit-ExtraBold": require("./Assets/Fonts/Outfit-ExtraBold.ttf"),
    "Outfit-Medium": require("./Assets/Fonts/Outfit-Medium.ttf"),
    "Outfit-Regular": require("./Assets/Fonts/Outfit-Regular.ttf"),
    "Outfit-SemiBold": require("./Assets/Fonts/Outfit-SemiBold.ttf"),
    "Poppins-ExtraBold": require("./Assets/Fonts/Poppins-ExtraBold.ttf"),
    "Poppins-Medium": require("./Assets/Fonts/Poppins-Medium.ttf"),
    "Poppins-Regular": require("./Assets/Fonts/Poppins-Regular.ttf"),
    "Poppins-SemiBold": require("./Assets/Fonts/Poppins-SemiBold.ttf"),
    "Times New Roman": require("./Assets/Fonts/Times-New-Roman.ttf"),
  });

  const handleOnLayout = useCallback(async () => {
    if (isLoaded) {
      await SplashScreen.hideAsync();
    }
  }, [isLoaded]);

  if (!isLoaded) {
    return null;
  }


  return (
    <View style={{ flex: 1 }}>
      <RootNavigation />
    </View>
  );
}
