
# Puppeteer + Flask Scraper Project

This project shows how I used **Node.js with Puppeteer** to scrape data from websites and **Python Flask** to serve that data via an HTTP API. 
I used Docker to make everything work seamlessly.


## What this project does

- It uses **Puppeteer (Node.js)** to open a website and grab some data like title, heading, etc.
- Then, it uses **Flask (Python)** to host that scraped data and show it in JSON format in your browser.
- **Everything runs in Docker using a multi-stage build** .

---

## I used Docker to build the image
To get started, I cloned the repo and ran the following command to build the Docker image:

docker build -t puppeteer-flask-app .

This command built the image using a multi-stage Dockerfile, where the first stage is for scraping with Puppeteer and the second stage is for hosting the scraped data with Flask.

##  How I Ran the Container
To run the container, I passed the URL I wanted to scrape using the `SCRAPE_URL` environment variable. I used this command:

docker run -e SCRAPE_URL="https://books.toscrape.com/" -p 5000:5000 puppeteer-flask-app

This runs the container, starts the scraper, and makes the Flask server available on port 5000.


## How to Access the Hosted Scraped Data

Once the container is running, i copy my ec2 Public Ip then I can access the data from any browser by visiting:

http://65.0.103.47:5000

It will show the scraped content in JSON format. For example, if I scraped a book store, it might return details about the books.


json
{
  "heading": "All products",
  "title": "All products | Books to Scrape - Sandbox"
}

## Files in this project

- `scrape.js`: Node.js file that scrapes the data
- `server.py`: Flask app to serve the data
- `Dockerfile`: Multi-stage build setup
- `package.json`: Node.js dependencies
- `requirements.txt`: Flask requirement
