

# plumber #

Copyright (c) 2015 Bots Unit, 2015 G-Corp

__Version:__ 1.0.0

__Authors:__ Gregoire Lejeune ([`gregoire.lejeune@botsunit.com`](mailto:gregoire.lejeune@botsunit.com)).

This module allow you to deal with memory leak problems, binary and gargabe collection

See :
* http://blog.bugsense.com/post/74179424069/erlang-binary-garbage-collection-a-lovehate
* https://blog.heroku.com/archives/2013/11/7/logplex-down-the-rabbit-hole
* http://dieswaytoofast.blogspot.fr/2012/12/erlang-binaries-and-garbage-collection.html
* https://andy.wordpress.com/2012/02/13/erlang-is-a-hoarder/



This code is based on logplex_leak.erl <br />
Copyright (c) 2010-2013 Heroku <jacob.vorreuter@gmail.com>, <nem@erlang.geek.nz>


## Usage ##

Add the following configuration in your application :
```

{plumber, [
  {memory_threshold, 10000000000}, # bytes
  {memory_check_interval, 5}       # minute
]},

```


Then start the `plumber` application.


## Licence ##

Copyright (c) 2015, G-Corp <greg@g-corp.io><br />
Copyright (c) 2015, Bots Unit <gregoire.lejeune@botsunit.com><br />
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
1. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.


THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

