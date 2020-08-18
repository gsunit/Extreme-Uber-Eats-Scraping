# Extreme Uber Eats Scraping

## Folder description
 - `/archive` contains data and scripts for reference purposes only while the project was being worked on
 - `/assets` contains image assets for README
 - `/notebooks` contains all the scripts used for scraping in the form of Jupyter Notebooks
 - `/scraped-data` contains all the scraped data city-wise
    - `/scraped-data/restaurant-categories` contains the stored category (cuisine) info for Uber Eats
    - `/scraped-data/resturant-urls` contains the files corresponding to each city which store the URLs of all restaurants in that city
    - `/scraped-data/restaurant-details` contains the files correspionding to each city which store the complete data of all restaurants in that city
    - `/scraped-data/UE-cities.csv` contains the list of all cities and corresponding URLs in which Uber Eats is operational
 - `/1.5M-Uber-Eats-Restaurants.zip` contains the zipped csv file which is the collection of all the data from `/scraped-data/restaurant-details` into a single csv

## What data are we extracting?
Here is a screenshot of one of the Uber Eats restaurants.

<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/rest_detail_1.png" width="700" alt="Rest details 1"/></kbd>
<p></p>

<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/rest_detail_2.png" width="350" alt="Rest details 2"/></kbd>
<p></p>

## What does the scraped data look like?
Good question! I had to sacrifice the head of one my DataFrames (pun intended) for this demonstration, but here you go!
<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/df_head_1.png" height="150" alt="data ss 1"/></kbd>
<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/df_head_2.png" height="150" alt="data ss 2"/></kbd>

## Step #1 - Enlist all Uber Eats cities
<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/scrape_1.png" height="400" alt="scrape 1"/></kbd>
<p></p>

[`cities.ipynb`](https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/notebooks/cities.ipynb) contains the code to fetch names and URLs of each city Uber Eats is operational in USA. As of the July 2020, they were a dozen shy of 33k cities. This first step is crucial as we would later make calls to the every city's page.

## Step #2 - Fetch and shortlist cuisines
<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/scrape_2.png" height="500" alt="scrape 2"/></kbd>
<p></p>

[`sort-categories.ipynb`]() contains the code to shortlist the most popular cuisines out of the total (200+) tags on Uber Eats. To collect the tags go to [https://www.ubereats.com/location](https://www.ubereats.com/location) and `Ctrl+A` + `Ctrl+C` the categories into a text file. Then read the file using Python, turn `spaces` into `-` and each letter to lowercase.

To shortlist the most popular categories I fetched all the restaurants for NYC (using steps #1 to #5), and stored the no. of restaurants for each category in a dict. Then simply fetch the top 50. Done!

**Yes, I had to assume that other cities would follow suit. And yes, I added a few of my favourite cuisines too :)**

## Step #3 - Scrape restaurant URLs for each city
<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/scrape_3.png" height="300" alt="scrape 3"/></kbd>
<p></p>

[`restaurant-urls.ipynb`](https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/notebooks/restaurant-urls.ipynb) contains the code to fetch urls of all the restuarants in a city. This step is a bit tricky and time-consuming. Uber Eats does not serve you the list of all restaurants on a platter. However, while surfing through their pages, I started observing patterns. So to get an exhaustive list of all restaurants (**quickly**), I came up with this:

- To navigate to a city's page you can simply add city's name at the end of `https://ubereats.com/location/`. So the NYC's URL would look like [`https://ubereats.com/location/new-york`](`https://ubereats.com/location/new-york`). However, you would see the featured restaurants here.
- Also, if you add the city's name followed by a category name at the end of `https://ubereats.com/category/`, you will get the complete list of all the restaurants in the city (but only with that category tag). For instance, [`https://ubereats.com/category/new-york/indian`].
- Fetch complete list of each category restaurants
- Keep adding their urls to a Set. In this way, no restaurants will be stored twice. However, you would have to repeat the process for 200+ categories. 

Who has that much time? Notice, that for there are hardly any restaurants which have only a single tag.

**So we would have covered about 90% of the restaurants in just the top 30 cuisines.**

## Step #4 - Fetch details for each restaurant URL
<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/scrape_4.png" height="400" alt="scrape 4"/></kbd>
<p></p>

[`restaurant-details.ipynb`](https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/notebooks/restaurant-details.ipynb) contains the code to fetch details of restaurants. After doing all the hard work, this should be nice and easy! However, some cities can have more than 3000 restaurants. Make sure to parallelize the loop while processing restaurants in a city.

**Word of caution: Threads under threads is not a good idea! Do not try to make threads for cities once you have parallelized the restaurants.**

## Step #5 - Finally, combine and process the data
[`post-processing.ipynb`](https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/notebooks/post-processing.ipynb) contains the code to combine the restaurant details csv of each city, and finally perform processing.

<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/scrape_6.png" width="800" alt="scrape 6"/></kbd>
<p></p>
