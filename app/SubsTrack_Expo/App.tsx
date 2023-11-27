import React, { useEffect } from 'react';
import { Platform, StatusBar } from 'react-native';
import { SubscriptionProvider } from './Src/Components/SubscriptionContext';
import Root from './Src/setup';
import { FIREBASE_APP } from './FirebaseConfig';


const App = (props: any) => {
  return (
    <SubscriptionProvider>
      <Root />
    </SubscriptionProvider>
  );
};
FIREBASE_APP;
export default App;
