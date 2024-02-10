// models/subscription.js
const mongoose = require('mongoose');

const subscriptionSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  name: { type: String, required: true },
  type: { type: String },
  cost: { type: Number },
  dueDate: { type: Date } // Represents the due date for the subscription
});

const Subscription = mongoose.model('Subscription', subscriptionSchema);

module.exports = Subscription;


