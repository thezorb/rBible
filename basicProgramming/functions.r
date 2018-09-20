say.hello <- function()
{
  print("Hello, World!")
}

say.hello
say.hello()

#basics of function arguments
sprintf("hello %s", "Jared")
sprintf("hello %s, today is %s", "Jared", "Sunday")

hello.person <- function(name)
{
  print(sprintf("Hello %s", name))
}
hello.person("Jared")
hello.person("Bob")
hello.person("Sarah")

hello.person <- function(first, last)
{
  print(sprintf("Hello %s %s", first, last))
}
hello.person("Jared", "Lander")
hello.person(last="Lander", first="Jared")

hello.person <- function(first, last ="Doe")
  {
  print(sprintf("Hello %s %s", first, last))
}
hello.person("Jared", "Lander")
hello.person("Jared")
hello.person(last="Lander") #error cause we didn't define first
hello.person("Jared", extra="Goodbye") #error cause there's a third argument

hello.person <- function(first, last ="Doe",...)
{
  print(sprintf("Hello %s %s", first, last))
}
hello.person("Jared", extra="Goodbye") 
hello.person("Jared", "Lander", "Goodbye")

double.num <- function(x)
{
  x * 2
}
double.num(3)
double.num(5)

double.num <- function(x)
{
  return(x * 2)
  
  print("Hello!")
  return(17)
}
double.num(3)
double.num(5)
