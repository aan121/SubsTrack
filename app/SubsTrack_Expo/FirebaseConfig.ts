// FirebaseConfig.ts

import { initializeApp } from 'firebase/app';
import { getAuth, GoogleAuthProvider, createUserWithEmailAndPassword } from 'firebase/auth';

const firebaseConfig = {
  apiKey: "AIzaSyBdbqtQCLDSlVmg5Wj-JFeA9AfxHFEeFr4",
  authDomain: "substrackapp-1c452.firebaseapp.com",
  projectId: "substrackapp-1c452",
  storageBucket: "substrackapp-1c452.appspot.com",
  messagingSenderId: "158875451799",
  appId: "1:158875451799:web:fa53bd8cf4d99fa1be04d2",
  measurementId: "G-2VM4HCHJH1"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
export const GOOGLE_PROVIDER = new GoogleAuthProvider();

export { app as FIREBASE_APP, auth as FIREBASE_AUTH, createUserWithEmailAndPassword };
