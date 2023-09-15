library(viridis)
library(MASS)
library(ggplot2)
library(gganimate)
library(sf)
library(transformr)
url <- "https://github.com/Anup-droid/India_Map/raw/main/Shape_files.zip"
download.file(url, "Shape_files.zip")
unzip("Shape_files.zip")
map_data <- st_read("Shape_files/state.shp")

# Load the data with values and time periods
# You should have a dataframe with columns: 'ID' (common identifier with the shapefile), 'value', and 'time_period'
data <- read.csv("C:/Users/Anup Kumar/Desktop/India_Map/ani_data.csv")
map_data <- merge(map_data, data, by = "OBJECTID", all.x = TRUE)
# Set up the base plot
base_plot <- ggplot(map_data) +
  geom_sf(aes(fill = FIC)) +
  scale_fill_viridis(option="rocket")+
  theme_void()+
  labs("Child Immunization",
       subtitle = "Child Immunization: FIC changes over time in India",
       caption = "Data Source: HMIS")
base_plot
# Create the animated plot
animated_plot <- base_plot +
  transition_time(Time) +
  labs(title = "Time: {frame_time}")+
  guides(fill = guide_colorbar(title = "FIC"))

# Play the animation
animate(animated_plot, nframes = 100, fps = 10)

#To save the animation
anim_save("C:/Users/Anup Kumar/Desktop/India_Map/FIC.gif", animate(animated_plot, nframes = 100, fps = 10))
