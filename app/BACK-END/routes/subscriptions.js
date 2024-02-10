// routes/subscriptions.js
const express = require('express');
const router = express.Router();
const Subscription = require('../models/subscription');

// Get all subscriptions for a user
router.get('/', async (req, res) => {
  try {
    const subscriptions = await Subscription.find({ user: req.userId });
    res.status(200).json(subscriptions);
  } catch (error) {
    console.error('Error fetching subscriptions:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// Add a new subscription
router.post('/', async (req, res) => {
  try {
    const newSubscription = new Subscription({
      user: req.userId,
      name: req.body.name,
      type: req.body.type,
      cost: req.body.cost,
      dueDate: req.body.dueDate
    });

    await newSubscription.save();
    res.status(201).json({ message: 'Subscription added successfully' });
  } catch (error) {
    console.error('Error adding subscription:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// Update an existing subscription
router.put('/:id', async (req, res) => {
  try {
    await Subscription.findByIdAndUpdate(req.params.id, req.body);
    res.status(200).json({ message: 'Subscription updated successfully' });
  } catch (error) {
    console.error('Error updating subscription:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// Delete a subscription
router.delete('/:id', async (req, res) => {
  try {
    await Subscription.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: 'Subscription deleted successfully' });
  } catch (error) {
    console.error('Error deleting subscription:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

module.exports = router;

