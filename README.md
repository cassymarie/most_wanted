# Most Wanted CLI

Welcome to the FBI's Most Wanted CLI.  Users can view the profile information about individuals that the FBI are looking for based on the different crime categories.  

## Installation

1. Clone the most_wanted-cli: `git clone 'https://github.com/cassymarie/most_wanted'`
2. Go into the cli directory `cd most_wanted`
3. Run `bundle install`
4. Run `.\bin\most_wanted`


## Usage

Most Wanted individuals are categorized by the crimes they are involved in.  The directory as seen below, the user enters the corresponding number to navigate through the menus to the individual profiles.

```Ruby
1. Top Ten
2. Fugitives
    1. Crimes Against Children
    2. Murders
    3. Cyber
    4. White Collar Crimes
    5. Counterintelligence
    6. Criminal Enterprise Investigations
    7. Human Trafficking
    8. Additional Violent Crimes
3. Terrorism
    1. Seeking Info - Terrorism
    2. Most Wanted Terrorist
    3. Domestic Terrorism
4. Seeking Info
    1. Seeking Info
    2. Law Enforcement Assistance
5. Kidnap/Missing Persons
6. Others
    1. Violent Criminal Apprehension Program
    2. Parental Kidnappings
    3. Known Bank Robbers
    4. Endangered Child Alert Program
7. Search By
    1. City Field Office
    2. Random Cases
    3. Total Cases
```

Once a category is chosen, navigate through the profiles using the keys listed at the bottom of the page or go back to previous menus.  

```[p] Previous  [n] Next  [view] View Files  [menu] Main Menu  [exit] Exit Program```

Entering `view` will take the user to the official FBI's Wanted poster.  

View the Most Wanted [walkthrough video here](./video/walkthrough.mp4)


## Development

All work has been completed on the `origin-master` branch.  Multiple commits have been made throughout the development of the app.  

Future development ideas:  
   - Create a list option for the profiles
   - Loop through/update all the different profiles, based on city selection


## Contributing

Learn.co / Flatiron Phase 1 course topics have helped through most, if not all the issues.  

Google has been an extreme help finding all the guidance needed at 2 am for easier method calls.  

The following sites were a blessing to help with either the design or functionality for completion. 

[ASCII generator](http://www.network-science.de/ascii/) \| [Rubular](https://rubular.com/) \| [Ruby-docs/classes](https://ruby-doc.org/core-2.7.2/index.html#classes) \| [HTML tag removal](https://snippets.aktagon.com/snippets/192-removing-html-tags-from-a-string-in-ruby)

Additionally, my husband helped with questions, best practices and some code reviews. 

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
