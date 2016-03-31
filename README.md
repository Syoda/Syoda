# Syoda
CodePath Group Project
**Syoda** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api). It is basically like Tinder, but for food, which gives you an instant feed of restaurants near you when you're hungry or looking for something new!

## APIs
We will be using the Yelp Search API to find local restaurants around you, and to allow users to enter parameters into what they want to eat.

## Models
Business Class
- id
- name
- address
- website
- rating
- ratingsCount
- latestReview
- headerPicture
- snippetText

Review
- rating
- user
- excerpt
- time

User
- username
- picture

## User Stories

- [ ] Users can see a list of restaurants close by.
- [ ] Users can swipe right to like a restaurant.
- [ ] Users can swipe left to dislike restaurant.
- [ ] Users can tap on restaurant to get more information.

## Optional Features
- [ ] Users can go to restaurants menu, website and other info from profile.
- [ ] Users can receive food suggestions based on previous likes and dislikes.

## Wireframes
![alt text](Wireframes/Home.png "Home")
![alt text](Wireframes/Details.png "Home")
![alt text](Wireframes/Matches.png "Matches")

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src= 'http://i.imgur.com/Vjtkym5.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## License

    Copyright [2016] [Aditya Balwani, Harpreet Singh, Philippe Kimura-Thollander]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
