# Extreme Uber Eats Scraping

## Step #1 - Gather city names and URLs
[`cities.ipynb`]() contains the code to fetch names and URLs of each city Uber Eats is operational in USA. As of the July 2020, they were a dozen shy of 33k cities. This first step is crucial as we would later make calls to the every city's page.

## Step #2 - Gather cuisines and select the popular ones
[`sort-categories.ipynb`]() contains the code to shortlist the most popular cuisines out of the total (200+) tags on Uber Eats. To collect the tags go to [https://www.ubereats.com/location](https://www.ubereats.com/location) and `Ctrl+A` + `Ctrl+C` the categories into a text file. Then read the file using Python, turn `spaces` into `-` and each letter to lowercase.

To shortlist the most popular categories I fetched all the restaurants for NYC (using steps #1 to #5), and stored the no. of restaurants for each category in a dict. Then simply fetch the top 50. Done!

**Yes, I had to assume that other cities would follow suit**
**And yes, I added a few of my favourite cuisines too :)**

## Step #3 - For each city, fetch restaurant URLs
[`restaurant-urls.ipynb`]() contains the code to fetch urls of all the restuarants in a city. This step is a bit tricky and time-consuming. Uber Eats does not serve you the list of all restaurants on a platter. However, while surfing through their pages, I started observing patterns. So to get an exhaustive list of all restaurants (**quickly**), I came up with this:

- To navigate to a city's page you can simply add city's name at the end of `https://ubereats.com/location/`. So the NYC's URL would look like [`https://ubereats.com/location/new-york`](`https://ubereats.com/location/new-york`). However, you would see the featured restaurants here.
- Also, if you add the city's name followed by a category name at the end of `https://ubereats.com/category/`, you will get the complete list of all the restaurants in the city (but only with that category tag). For instance, [`https://ubereats.com/category/new-york/indian`].
- Fetch complete list of each category restaurants
- Keep adding their urls to a Set. In this way, no restaurants will be stored twice. However, you would have to repeat the process for 200+ categories. 

Who has that much time? Notice, that for there are hardly any restaurants which have only a single tag.

**So we would have covered about 90% of the restaurants in just the top 30 cuisines.**

## Step #4 - For each restaurant URL, fetch details
[`restaurant-detials.ipynb`]() contains the code to fetch details of restaurants. After doing all the hard work, this should be nice and easy! However, some cities can have more than 3000 restaurants. Make sure to parallelize the loop while processing restaurants in a city.

**Word of caution: do not try to make threads for cities once you have parallelized the restaurants. Threads under threads is not a good idea!**

## Step #5 - Finally, combine and process the data
[`post-processing.ipynb`]() contains the code to combine the restaurant details csv of each city, and finally perform processing.


#### Data
 - `UE-categories-popular.txt`: poular categories (shortlisted based on the num of restaurants in NY with these tags)
 - `UE-categories-other.txt`: less popular categories (shortlisted based on the num of restaurants in NY with these tags)
 - `UE-categories-all.txt`: combination of `popular` and `other` categories, all categories that I could find (might not be exhaustive)
 - `UE-cities.csv`: exhaustive list of all the cities in which Uber Eats is operational and corresponding urls

