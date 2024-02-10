import React, { createContext, useContext, useState, ReactNode } from 'react';

export type Subscription = {
  id: string;
  name: string;
  cost: string;
  billingDate: string;
  cycle: string;
  category: string;
};

type SubscriptionContextType = {
  subscriptions: Subscription[];
  addSubscription: (subscription: Subscription) => void;
  deleteSubscription: (subscriptionId: string) => void;
  getSubscriptionImage: (subscriptionName: string) => any;
};

const SubscriptionContext = createContext<SubscriptionContextType | undefined>(undefined);

type SubscriptionProviderProps = {
  children: ReactNode;
};

export const SubscriptionProvider: React.FC<SubscriptionProviderProps> = ({ children }) => {
  const [subscriptions, setSubscriptions] = useState<Subscription[]>([]);

  const addSubscription = (subscription: Subscription) => {
    setSubscriptions([...subscriptions, subscription]);
  };

  const deleteSubscription = (subscriptionId: string) => {
    setSubscriptions(subscriptions.filter((subscription) => subscription.id !== subscriptionId));
  };

  const getSubscriptionImage = (subscriptionName: string) => {
    switch (subscriptionName.toLowerCase()) {
      case 'substrack':
        return require('../Assets/Icons/dLogo.png');
      case 'youtube':
        return require('../Assets/Icons/youtubeLogo.png');
      case 'netflix':
        return require('../Assets/Icons/netflixLogo.png');
      case 'hulu':
        return require('../Assets/Icons/huluLogo.png');
      case 'hbo':
        return require('../Assets/Icons/hboLogo.png');
      case 'doordash':
        return require('../Assets/Icons/doordashLogo.png');
      case 'disney':
        return require('../Assets/Icons/disneyLogo.png');
      case 'apple tv':
        return require('../Assets/Icons/appletvLogo.png');
      case 'amazon prime':
        return require('../Assets/Icons/amazonLogo.png');
      // Add other cases as needed
      default:
        return require('../Assets/Icons/dLogo.png');
    }
  };

  return (
    <SubscriptionContext.Provider value={{ subscriptions, addSubscription, deleteSubscription, getSubscriptionImage }}>
      {children}
    </SubscriptionContext.Provider>
  );
};

export const useSubscriptionContext = () => {
  const context = useContext(SubscriptionContext);
  if (context === undefined) {
    throw new Error('useSubscriptionContext must be used within a SubscriptionProvider');
  }
  return context;
};


