# Extreme Uber Eats Scraping

#### Script Jupyter Notebooks
 - `cities.ipynb`: Script to fetch names and URLs of each city Uber Eats is operational in 
 - `sort-categories.ipynb`: Script to shortlist the most popular cuisines out of the total (200+) tags on Uber Eats
 - `restaurant-detials.ipynb`: Script to fetch detials of restaurants
 - `restaurant-urls.ipynb`: Script to fetch urls of all restuarants in a city
 - `post-processing.ipynb`: Script to combine the restaurant details csv of each city, and finally perform processing

#### Data
 - `UE-categories-popular.txt`: poular categories (shortlisted based on the num of restaurants in NY with these tags)
 - `UE-categories-other.txt`: less popular categories (shortlisted based on the num of restaurants in NY with these tags)
 - `UE-categories-all.txt`: combination of `popular` and `other` categories, all categories that I could find (might not be exhaustive)
 - `UE-cities.csv`: exhaustive list of all the cities in which Uber Eats is operational and corresponding urls

