const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/Subscription', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Define a schema for subscriptions
const subscriptionSchema = new mongoose.Schema({
  name: String,
  cost: Number,
  billingDate: String,
  cycle: String,
  category: String,
});

// Create a model based on the schema
const Subscription = mongoose.model('Subscription', subscriptionSchema);

app.use(cors());
app.use(express.json());

// API endpoint to save a new subscription
app.post('/api/subscriptions', async (req, res) => {
  try {
    const newSubscription = await Subscription.create(req.body);
    res.status(201).json(newSubscription);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// API endpoint to get all subscriptions
app.get('/api/subscriptions', async (req, res) => {
  try {
    const subscriptions = await Subscription.find();
    res.status(200).json(subscriptions);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// API endpoint to delete a subscription by ID
app.delete('/api/subscriptions/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const deletedSubscription = await Subscription.findByIdAndDelete(id);

    if (!deletedSubscription) {
      return res.status(404).json({ error: 'Subscription not found' });
    }

    res.status(200).json(deletedSubscription);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
