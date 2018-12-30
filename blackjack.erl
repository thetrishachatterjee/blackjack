%%%-------------------------------------------------------------------
%%% @author Trisha Chatterjee
%%% @copyright (C) 2018, Trisha Chatterjee
%%% @doc
%%%
%%% @end
%%% Created : 26. Dec 2018 7:51 PM
%%%-------------------------------------------------------------------
-module(blackjack).
-author("thetrishachatterjee").

%% API
-export([
  create_deck/0,
  start_game/1
]).
create_deck() ->
  deck:create_ets_tables(),
  Ranks = get_ranks(),
  Suits = get_suits(),
  deck:create_cards(Ranks, Suits),
  RankValues = get_rank_values(),
  deck:associate_value_to_rank(RankValues),
  ok.

start_game(NumberOfDecks) ->
  deck:initialize_shuffled_deck(NumberOfDecks).


%%==============================
%% Internal Block
%%==============================
get_rank_values() ->
  [
    {<<"A">>, [1, 11]},
    {<<"2">>, 2},
    {<<"3">>, 3},
    {<<"4">>, 4},
    {<<"5">>, 5},
    {<<"6">>, 6},
    {<<"7">>, 7},
    {<<"8">>, 8},
    {<<"9">>, 9},
    {<<"10">>, 10},
    {<<"J">>, 10},
    {<<"Q">>, 10},
    {<<"K">>, 10}
  ].
get_ranks() ->
  [
    <<"A">>,
    <<"2">>,
    <<"3">>,
    <<"4">>,
    <<"5">>,
    <<"6">>,
    <<"7">>,
    <<"8">>,
    <<"9">>,
    <<"10">>,
    <<"J">>,
    <<"Q">>,
    <<"K">>
  ].

get_suits() ->
  [
    <<"hearts">>,
    <<"diamonds">>,
    <<"spades">>,
    <<"clubs">>
  ].
