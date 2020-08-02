# Extreme Uber Eats Scraping


## What does the data look like?
Good question! I had to sacrifice the head of one my DataFrames (pun intended) for this demonstration, but here you go!
<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/df_head_1.png" height="150" alt="data ss 1"/></kbd>
<p></p>
<kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/df_head_2.png" height="150" alt="data ss 2"/></kbd>

## What does the data look like (on a map)?
Glad you asked! I am aware how beautiful it would look, so I went ahead and marked the restaurants on a Google Map. The screenshots include a zoomed-out view of NYC and another a street-view of NYC.
<p></p>



 
| NYC Restaurants | NYC Street View |
| ------------- | ------------- |
| <kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/app_ss_1.jpg" height="500" alt="app ss 1"/></kbd> | <kbd><img src="https://github.com/gsunit/Extreme-Uber-Eats-Scraping/blob/master/assets/app_ss_2.jpg" height="500" alt="app ss 2"/></kbd> |


## Step #1 - Gather city names and URLs
[`cities.ipynb`]() contains the code to fetch names and URLs of each city Uber Eats is operational in USA. As of the July 2020, they were a dozen shy of 33k cities. This first step is crucial as we would later make calls to the every city's page.

## Step #2 - Gather cuisines and select the popular ones
[`sort-categories.ipynb`]() contains the code to shortlist the most popular cuisines out of the total (200+) tags on Uber Eats. To collect the tags go to [https://www.ubereats.com/location](https://www.ubereats.com/location) and `Ctrl+A` + `Ctrl+C` the categories into a text file. Then read the file using Python, turn `spaces` into `-` and each letter to lowercase.

To shortlist the most popular categories I fetched all the restaurants for NYC (using steps #1 to #5), and stored the no. of restaurants for each category in a dict. Then simply fetch the top 50. Done!

**Yes, I had to assume that other cities would follow suit. And yes, I added a few of my favourite cuisines too :)**

## Step #3 - For each city, fetch restaurant URLs
[`restaurant-urls.ipynb`]() contains the code to fetch urls of all the restuarants in a city. This step is a bit tricky and time-consuming. Uber Eats does not serve you the list of all restaurants on a platter. However, while surfing through their pages, I started observing patterns. So to get an exhaustive list of all restaurants (**quickly**), I came up with this:

- To navigate to a city's page you can simply add city's name at the end of `https://ubereats.com/location/`. So the NYC's URL would look like [`https://ubereats.com/location/new-york`](`https://ubereats.com/location/new-york`). However, you would see the featured restaurants here.
- Also, if you add the city's name followed by a category name at the end of `https://ubereats.com/category/`, you will get the complete list of all the restaurants in the city (but only with that category tag). For instance, [`https://ubereats.com/category/new-york/indian`].
- Fetch complete list of each category restaurants
- Keep adding their urls to a Set. In this way, no restaurants will be stored twice. However, you would have to repeat the process for 200+ categories. 

Who has that much time? Notice, that for there are hardly any restaurants which have only a single tag.

**So we would have covered about 90% of the restaurants in just the top 30 cuisines.**

## Step #4 - For each restaurant URL, fetch details
[`restaurant-details.ipynb`]() contains the code to fetch details of restaurants. After doing all the hard work, this should be nice and easy! However, some cities can have more than 3000 restaurants. Make sure to parallelize the loop while processing restaurants in a city.

**Word of caution: Threads under threads is not a good idea! Do not try to make threads for cities once you have parallelized the restaurants.**

## Step #5 - Finally, combine and process the data
[`post-processing.ipynb`]() contains the code to combine the restaurant details csv of each city, and finally perform processing.
