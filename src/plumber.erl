% This code is  based on logplex_leak.erl
%
% Original licence :
%
% Copyright (c) 2010-2013 Heroku <jacob.vorreuter@gmail.com>
% <nem@erlang.geek.nz>
%
% Permission is hereby granted, free of charge, to any person  
% obtaining a copy of this software and associated documentation  
% files (the "Software"), to deal in the Software without  
% restriction, including without limitation the rights to use,  
% copy, modify, merge, publish, distribute, sublicense, and/or sell  
% copies of the Software, and to permit persons to whom the  
% Software is furnished to do so, subject to the following  
% conditions:  
%
% The above copyright notice and this permission notice shall be  
% included in all copies or substantial portions of the Software.  
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,  
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES  
% OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND  
% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT  
% HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,  
% WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING  
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR  
% OTHER DEALINGS IN THE SOFTWARE.  
%
% Modifications :
%
% Gregoire Lejeune <greg@g-corp.io>
-module(plumber).
-compile([{parse_transform, lager_transform}]).
-behaviour(gen_server).

-define(CHECK_INTERVAL, 5).
-define(MEMORY_THRESHOLD, 10000000000).

-record(state, {
          tref,
          threshold,
          check_interval
         }).

-export([start_link/0, force/0, state/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         code_change/3, terminate/2]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

force() ->
  gen_server:call(?MODULE, force, timer:seconds(10)).

state() ->
  [{K,V / math:pow(1024,3)} || {K,V} <- erlang:memory()].

init([]) ->
  Ref = erlang:start_timer(0, self(), gc),
  {ok, #state{
          tref = Ref,
          threshold = plumber_config:conf([plumber, memory_threshold], ?MEMORY_THRESHOLD),
          check_interval = timer:minutes(
                             plumber_config:conf(
                               [plumber, memory_check_interval], ?CHECK_INTERVAL))
         }}.

handle_call(force, _, S = #state{tref = Ref, 
                                 check_interval = Interval}) ->
  _ = erlang:cancel_timer(Ref),
  Before = erlang:memory(total),
  [erlang:garbage_collect(Pid) || Pid <- processes()],
  NewRef = erlang:start_timer(Interval, self(), gc),
  After = erlang:memory(total),
  lager:debug("at=gc mem_pre=~p mem_post=~p type=forced", [Before, After]),
  {reply, ok, S#state{tref = NewRef}};
handle_call(_, _, State) ->
  {noreply, State}.

handle_cast(_, State) ->
  {noreply, State}.

handle_info({timeout, Ref, gc}, S = #state{tref = Ref,
                                          threshold = Threshold,
                                          check_interval = Interval}) ->
  Mem = erlang:memory(total),
  case Mem >= Threshold of
    true ->
      [erlang:garbage_collect(Pid) || Pid <- processes()],
      After = erlang:memory(total),
      lager:debug("at=gc mem_pre=~p mem_post=~p type=timeout", [Mem, After]);
    false ->
      ok
  end,
  NewRef = erlang:start_timer(Interval, self(), gc),
  {noreply, S#state{tref = NewRef}};
handle_info(_WhoCares, State=#state{}) ->
  {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
  {ok,State}.

terminate(_,_) -> ok.

