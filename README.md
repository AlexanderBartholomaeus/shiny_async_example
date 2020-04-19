# Shiny async/parallel example 
Shiny App example of asyn / parallel execution to prevent blocking different sessions

## Intro
Shiny is a great to easily transform R tools and visualizations to interactive app. However, if the app is host as a web-app and multiple users access it at the same time then computation influence all session. The computations of one user will block the session of the other user. The bad thing: The user that is block does not know about this. Simply nothing will happen when clicking a button which is not a nice responsive design.

This code example show the problem and the solution to the problem by implementing a simple 'parallel' process that will not influence the other sessions.

## More infos

More information you can find here:
[Rstudio blog](https://blog.rstudio.com/2018/06/26/shiny-1-1-0/)

## Usage

### Install

The following packages are needed: `shiny`, `promises` and `future`. Just install by:
```
install.packages('shiny','promises','future')
```

### Explore

To illustrate parallel and non-parallel (blocked) execution start the app and open two windows of the app in your browser. This will cause two indendent sessions simulating two different users.

Select the number of dummy calculation in the first window/session such that you see the waiting indicator for a while. This will give you the opportunity to hit the execution button in the second session (execution time can be short in second session). 

When you hit non-parallel execution in the first session and immediately execute the calculation in the second session nothing will happen there. The second session will only respond when the first session finishes. If you now increase the execution number and time in the first session you see that the second session can be blocked really long.

Now hit the parallel execution button in the first session followed be execution in second session you see that the second session execution will be executed immediately. Problem solved

![Image of example](https://github.com/AlexanderBartholomaeus/shiny_async_example/blob/master/shiny_async_example.png)


