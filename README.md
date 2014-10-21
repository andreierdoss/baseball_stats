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

Some things that can still be improved:
* Model level data validation
* Separate model logic into concerns
* Implement a team model for better data encapsulation
* Add logic to handle triple crown tiebreaker
* Improve data import via bulk inserts (it is slow now due to reliance on callbacks to compute some fields)
* Test rake tasks to make sure that the appropriate methods are called
