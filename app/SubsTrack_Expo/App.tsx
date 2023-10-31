import React, { useEffect } from 'react';
import { Platform, StatusBar } from 'react-native';
import { SubscriptionProvider } from './Src/Components/SubscriptionContext';
import Root from './Src/setup';

const App = (props: any) => {
  return (
    <SubscriptionProvider>
      <Root />
    </SubscriptionProvider>
  );
};

export default App;
