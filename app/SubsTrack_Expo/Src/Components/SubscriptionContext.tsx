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
  addSubscription: (subscription: Subscription) => Promise<void>;
  deleteSubscription: (subscriptionId: string) => Promise<void>;
  getSubscriptionImage: (subscriptionName: string) => any;
};

const SubscriptionContext = createContext<SubscriptionContextType | undefined>(undefined);

type SubscriptionProviderProps = {
  children: ReactNode;
};

export const SubscriptionProvider: React.FC<SubscriptionProviderProps> = ({ children }) => {
  const [subscriptions, setSubscriptions] = useState<Subscription[]>([]);

  const addSubscription = async (subscription: Subscription) => {
    try {
      const response = await fetch('http://192.168.1.174:3000/api/subscriptions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(subscription),
      });

      if (response.ok) {
        const newSubscription = await response.json();
        setSubscriptions([...subscriptions, newSubscription]);
      } else {
        console.error('Failed to add subscription:', response.status);
        // Handle errors appropriately (e.g., show an error message to the user)
      }
    } catch (error) {
      console.error('Error adding subscription:', error);
      // Handle errors appropriately
    }
  };

  const deleteSubscription = async (subscriptionId: string) => {
    
    try {
      const response = await fetch(`http://192.168.1.174:3000/api/subscriptions/${subscriptionId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
      });
  
      if (response.ok) {
        setSubscriptions(subscriptions.filter((subscription) => subscription.id !== subscriptionId));
      } else {
        console.error('Failed to delete subscription:', response.status);
        // Handle errors appropriately
      }
    } catch (error) {
      console.error('Error deleting subscription:', error);
      // Handle errors appropriately
    }
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
