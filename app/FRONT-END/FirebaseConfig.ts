// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAqMbYAZaCdfZGSBr9WWr7iqKppwiGzKLg",
  authDomain: "substracks-f9f51.firebaseapp.com",
  projectId: "substracks-f9f51",
  storageBucket: "substracks-f9f51.appspot.com",
  messagingSenderId: "968702256300",
  appId: "1:968702256300:web:88778673bae15464472b09",
  measurementId: "G-532JL1JRFJ"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const auth = getAuth(app); // Initialize Firebase Auth
const analytics = getAnalytics(app);
const db = getFirestore(app); // Initialize Firestore database

export { app as FIREBASE_APP, auth as FIREBASE_AUTH, db as FIREBASE_DATABASE, createUserWithEmailAndPassword, signInWithEmailAndPassword };