## Total attributes from API
  
```Ruby
#Total attributes receied from API...

[:@additional_information,:@age_max,:@age_min,:@age_range,:@aliases,:@build,:@caution,:@complexion,:@coordinates,:@dates_of_birth_used,:@description,:@details,:@eyes,:@eyes_raw,:@field_offices,:@files,:@hair,:@hair_raw,:@height_max,:@height_min,:@images,:@languages,:@modified,:@nationality,:@ncic,:@occupations,:@path,:@person_classification,:@place_of_birth,:@possible_countries,:@possible_states,:@publication,:@race,:@race_raw,:@remarks,:@reward_max,:@reward_min,:@reward_text,:@scars_and_marks,:@sex,:@status,:@subjects,:@suspects,:@title,:@uid,:@url,:@wanted_id,:@warning_message,:@weight,:@weight_max,:@weight_min]

#Separating into two Classes
Person: {
     :age, :aliases, :build, :dates_of_birth, :eyes, :hair, :height, :languages, :name, :nationality, :occupations, :path, :classification, :place_of_birth, :race, :scars_and_marks, :sex, :status, :title, :uid, :weight,
}

Case: {
     :individuals, :additional_information, :caution, :description, :details, :field_offices, :files, :images, :remarks, :possible_countries, :possible_states, :reward_max, :reward_text, :subjects, :url, :warning_message
}




```

