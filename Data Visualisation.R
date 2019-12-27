#load the library
library(tidyverse)
#choose the dataset
mpg
#get details about the dataset
?mpg
#to visualize the relationship between engine displacement and efficience
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))
#view the dataset in a rectangular window
View(mpg)
#how about ggplot(data=mpg)
ggplot(data=mpg)
#how many rows are in mpg?
nrow(mpg)
#234
#"drv" variable describe the drive syle of cars.
#Make a scatterplot of hwy vs cyl.
ggplot(data=mpg)+geom_point(mapping=aes(x=hwy,y=cyl))
#What happens if you make a scatterplot of class vs drv? 
#Why is the plot not useful?
ggplot(data=mpg)+geom_point(mapping=aes(x=drv,y=class))
#because "drv" and "class" are categorical variables.
#You can convey information about your data by mapping 
#the aesthetics in your plot to the variables in your dataset. 
#For example, you can map the colors of your points to the 
#class variable to reveal the class of each car.
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,color=class))
#you may notice that I don't include mapping argument, but it 
#wouldn't affect your result.
#in the above, we mapped class to the color aesthetic
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,size=class))
#after you run the code, you will get a warning message, because
#mapping an unordered variable to an ordered aesthetic is not a good idea.
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,alpha=class))
#we can map class to the alpha aesthetic, which controls the transparency
#of the points. Also it is still not recommended.
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy, shape=class))
#what happened to SUV? The shape palette can deal with a maximum of 6 discrete values
#because more than 6 becomes difficult to discriminate.
#---
#you can also set the aesthetic properties of your geom manually.
#for example, you can make all of the points in our plot blue.
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy), color="blue")
#To set an aesthetic manually, set the aesthetic by name as an argument of your geom function; 
#i.e. it goes outside of aes(). You’ll need to pick a level that makes sense for that aesthetic:
#---
#Map a continuous variable to color, size, and shape. How do these aesthetics behave 
#differently for categorical vs. continuous variables?
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy, shape=cty))
#warning message:A continuous variable can not be mapped to shape.
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy, size=cty))
#it is fine
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy, color=cty))
#although there is no warning message, I still don't think it is good plot.
#---
#hat happens if you map the same variable to multiple aesthetics?
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy, color=class,shape=class))
#it is easier for readers to recognize the difference.
#---
#What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
?geom_point
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)
# For shapes that have a border (like 21), you can colour the inside and
# outside separately. Use the stroke aesthetic to modify the width of the
# border
#---
#What happens if you map an aesthetic to something other than a variable name
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,color=displ < 5))
#---
#One way to add additional variables is with aesthetics. Another way, 
#particularly useful for categorical variables, is to split your plot into facets, 
#subplots that each display one subset of the data.
ggplot(data=mpg)+
  geom_point(aes(x=displ,y=hwy))+
  facet_wrap(~class,nrow=2)
#To facet your plot by a single variable, use facet_wrap(). 
#The first argument of facet_wrap() should be a formula, which you create with ~ followed by a variable name 
#(here “formula” is the name of a data structure in R, not a synonym for “equation”). 
#The variable that you pass to facet_wrap() should be discrete.
#---
#To facet your plot on the combination of two variables, add facet_grid() to your plot call. 
#The first argument of facet_grid() is also a formula. This time the formula should contain 
#two variable names separated by a ~.
ggplot(data=mpg)+
  geom_point(aes(x=displ,y=hwy))+
  facet_grid(drv~cyl)
?mpg
#geometric objects
ggplot(data=mpg,aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(aes(color=class))
#exercise
ggplot(data=mpg,aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(se=FALSE)
ggplot(data=mpg,aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(se=FALSE,aes(group=drv))
ggplot(data=mpg,aes(x=displ, y=hwy,color=drv))+
  geom_point()+
  geom_smooth(se=FALSE)
ggplot(data=mpg,aes(x=displ, y=hwy))+
  geom_point(aes(color=drv))+
  geom_smooth(se=FALSE)
ggplot(data=mpg,aes(x=displ, y=hwy))+
  geom_point(aes(color=drv))+
  geom_smooth(se=FALSE,aes(linetype=drv))
ggplot(data=mpg,aes(x=displ, y=hwy,color=drv))+
  geom_point()


