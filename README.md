# Shiny async example 
Shiny App example of asyn / parallel execution to prevent blocking different sessions

## Intro
Shiny is a great to easily transform R tools and visualizations to interactive app. However, if the app is host as a web-app and multiple users access it at the same time then computation influence all session. The computations of one user will block the session of the other user. 

This code example show how to overcome the problem by implementing a simple background process

## More infos

More information you can find here:
[Rstudio blog](https://blog.rstudio.com/2018/06/26/shiny-1-1-0/)

## Usage



