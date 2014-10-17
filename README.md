# Baseball Stats

## Requirements

This app uses Ruby and MongoDB

## Installation

Clone repo and then run the following to seed with data:

    rake seed:all

Please note this is will take aprox 3 to 4 minutes.

## Usage

Run the following to see stats for the first two exercises:

    rake stats:all

## Notes

Due to time constraint, I was only able to implement the first two exercises. I believe the current implementation is enough to show my thought process and the way I used software design principles to organize the code and resolve the requirements.

Some things that are still missing:
* Model level data validation
* Separate model logic into concerns
* Implement a team model for better data encapsulation
* Improve data import via bulk inserts (it is slow now due to reliance of callbacks to compute some fields)
* Test rake tasks to make sure that the appropriate methods are called
