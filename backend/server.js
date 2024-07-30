const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const puppeteer = require('puppeteer');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(bodyParser.json());
app.use(cors());

mongoose.connect('mongodb://localhost:27017/ride_sharing', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const priceEstimateSchema = new mongoose.Schema({
  startLocation: String,
  endLocation: String,
  price: String,
});

const PriceEstimate = mongoose.model('PriceEstimate', priceEstimateSchema);

app.post('/price-estimate', async (req, res) => {
  const { startLocation, endLocation } = req.body;

  // Add your web scraping logic here to get the price estimate
  const price = '$20 - $25'; // Dummy price estimate

  const newEstimate = new PriceEstimate({
    startLocation,
    endLocation,
    price,
  });

  await newEstimate.save();

  res.json({ price });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
