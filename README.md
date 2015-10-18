# Plumber

This module allow you to deal with memory leak problems, binary and gargabe collection

See :

* http://blog.bugsense.com/post/74179424069/erlang-binary-garbage-collection-a-lovehate 
* https://blog.heroku.com/archives/2013/11/7/logplex-down-the-rabbit-hole 
* http://dieswaytoofast.blogspot.fr/2012/12/erlang-binaries-and-garbage-collection.html 
* https://andy.wordpress.com/2012/02/13/erlang-is-a-hoarder/

## Usage

Add the following configuration in your application :

```
{plumber, [
  {memory_threshold, 10000000000}, # bytes
  {memory_check_interval, 5}       # minute
]},
```

Then start the `plumber` application.

