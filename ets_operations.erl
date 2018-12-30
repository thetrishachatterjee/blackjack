%%%-------------------------------------------------------------------
%%% @author Trisha Chatterjee
%%% @copyright (C) 2018, Trisha Chatterjee
%%% @doc
%%%
%%% @end
%%% Created : 29. Dec 2018 10:54 PM
%%%-------------------------------------------------------------------
-module(ets_operations).
-author("trishachatterjee2009@gmail.com").

%% API
-export([
  get_all/1
]).

get_all(Table) ->
  traverse(Table, ets:first(Table), []).

traverse(_Table, '$end_of_table', Acc) ->
  Acc;
traverse(Table, NextKey, Acc) ->
  traverse(Table, ets:next(Table, NextKey), [ets:lookup(Table, NextKey) | Acc]).
