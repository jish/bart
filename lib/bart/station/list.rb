
module Bart
  class Station

    LIST = [
      { :id => "12th", :name => "12th St. Oakland City Center" },
      { :id => "16th", :name => "16th St. Mission (SF)" },
      { :id => "19th", :name => "19th St. Oakland" },
      { :id => "24th", :name => "24th St. Mission (SF)" },
      { :id => "ashb", :name => "Ashby (Berkeley)" },
      { :id => "balb", :name => "Balboa Park (SF)" },
      { :id => "bayf", :name => "Bay Fair (San Leandro)" },
      { :id => "cast", :name => "Castro Valley" },
      { :id => "civc", :name => "Civic Center (SF)" },
      { :id => "cols", :name => "Coliseum" },
      { :id => "colm", :name => "Colma" },
      { :id => "conc", :name => "Concord" },
      { :id => "daly", :name => "Daly City" },
      { :id => "dbrk", :name => "Downtown Berkeley" },
      { :id => "dubl", :name => "Dublin/Pleasanton" },
      { :id => "deln", :name => "El Cerrito del Norte" },
      { :id => "plza", :name => "El Cerrito Plaza" },
      { :id => "embr", :name => "Embarcadero (SF)" },
      { :id => "frmt", :name => "Fremont" },
      { :id => "ftvl", :name => "Fruitvale (Oakland)" },
      { :id => "glen", :name => "Glen Park (SF)" },
      { :id => "hayw", :name => "Hayward" },
      { :id => "lafy", :name => "Lafayette" },
      { :id => "lake", :name => "Lake Merritt (Oakland)" },
      { :id => "mcar", :name => "MacArthur (Oakland)" },
      { :id => "mlbr", :name => "Millbrae" },
      { :id => "mont", :name => "Montgomery St. (SF)" },
      { :id => "nbrk", :name => "North Berkeley" },
      { :id => "ncon", :name => "North Concord/Martinez" },
      { :id => "oakl", :name => "Oakland Int'l Airport" },
      { :id => "orin", :name => "Orinda" },
      { :id => "pitt", :name => "Pittsburg/Bay Point" },
      { :id => "phil", :name => "Pleasant Hill" },
      { :id => "powl", :name => "Powell St. (SF)" },
      { :id => "rich", :name => "Richmond" },
      { :id => "rock", :name => "Rockridge (Oakland)" },
      { :id => "sbrn", :name => "San Bruno" },
      { :id => "sfia", :name => "San Francisco Int'l Airport" },
      { :id => "sanl", :name => "San Leandro" },
      { :id => "shay", :name => "South Hayward" },
      { :id => "ssan", :name => "South San Francisco" },
      { :id => "ucty", :name => "Union City" },
      { :id => "wcrk", :name => "Walnut Creek" },
      { :id => "woak", :name => "West Oakland" }
    ]

    ID_TO_NAME = LIST.inject({}) { |memo, i| memo[i[:id]] = i[:name]; memo }

  end
end
