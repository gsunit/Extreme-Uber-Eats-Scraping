# Extreme Uber Eats Scraping

## Step #1 - Gather city names and URLs
`cities.ipynb` contains the code to fetch names and URLs of each city Uber Eats is operational in USA. This first step is crucial as we would later make calls to the particular pages

## Step #2 - Gather cuisines and select the popular ones
`sort-categories.ipynb` contains the code to shortlist the most popular cuisines out of the total (200+) tags on Uber Eats

## Step #3 - For each city, fetch restaurant URLs
`restaurant-urls.ipynb` contains the code to fetch urls of all restuarants in a city

## Step #4 - For each restaurant URL, fetch details - `restaurant-detials.ipynb`
Script to fetch details of restaurants

## Step #5 - Finally, combine and process the data - `post-processing.ipynb`
Script to combine the restaurant details csv of each city, and finally perform processing


#### Data
 - `UE-categories-popular.txt`: poular categories (shortlisted based on the num of restaurants in NY with these tags)
 - `UE-categories-other.txt`: less popular categories (shortlisted based on the num of restaurants in NY with these tags)
 - `UE-categories-all.txt`: combination of `popular` and `other` categories, all categories that I could find (might not be exhaustive)
 - `UE-cities.csv`: exhaustive list of all the cities in which Uber Eats is operational and corresponding urls

