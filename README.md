## Architecture of App

1. This app is only using 2 apis to fetch data from https://docs.spacexdata.com.
2. To fetch all the launches api https://api.spacexdata.com/v3/launches is used.
3. To fetch the rocket info api https://api.spacexdata.com/v3/rockets/{{rocket_id}} is used.

# At main page of the app all the launches is showed and the user can sort the launches by launch year, launch success, and mission name.
# Upon further selecting specific launch at main page you can view the details about launch.

Note: This app can be further improved by improving UI/UX. As right now the app is primarly foucused on displaying data.


## Design patterns
In this project MVVM design pattren is used as it helps to keep the code organized. Furthermore the project is build in such a way it can be scaled easily if project grows.

