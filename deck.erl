%%%-------------------------------------------------------------------
%%% @author Trisha Chatterjee
%%% @copyright (C) 2018, Trisha Chatterjee
%%% @doc
%%%
%%% @end
%%% Created : 29. Dec 2018 7:45 PM
%%%-------------------------------------------------------------------
-module(deck).
-author("trishachatterjee2009@gmail.com").

%% API
-export([
]).
-export([
  create_ets_tables/0,
  create_cards/2,
  associate_value_to_rank/1,
  initialize_deck/1,
  initialize_shuffled_deck/1,
  shuffle_deck/1
]).
-include("modules.hrl").

%%===========================================
%% Misc Block
%%===========================================
create_ets_tables() ->
  case ets:info(card) of
    undefined ->
      ets:new(card, [named_table]);
    _ -> ok
  end,
  case ets:info(rank_value) of
    undefined ->
      ets:new(rank_value, [named_table]);
    _ -> ok
  end.

associate_value_to_rank(RankValues) ->
  ets:insert(rank_value, RankValues).

create_cards(RankValues, Suits) ->
  Deck = lists:foldl(
    fun(Suit, DeckAcc) ->
      lists:foldl(
        fun(Rank, DeckInnerAcc) ->
          [ {{Rank, Suit}} | DeckInnerAcc]
        end,
        DeckAcc,
        RankValues
      )
    end,
    [],
    Suits
  ),
  ets:insert(card, Deck).

%%===========================================
%% Initialize and Shuffle N Decks
%%===========================================
initialize_shuffled_deck(N) ->
  Deck = deck:initialize_deck(N),
  deck:shuffle_deck(Deck).

%%===========================================
%% Initialize N Decks
%%===========================================
initialize_deck(N) ->
  Cards = ets_operations:get_all(card),
  initialize_deck_internal(N, Cards).

initialize_deck_internal(1, Cards) ->
  Cards;
initialize_deck_internal(N, Cards) ->
  Cards ++ initialize_deck_internal(N-1, Cards).

%%===========================================
%% Shuffle
%%===========================================
shuffle_deck(Deck) ->
  knuth_shuffle(Deck, []).

knuth_shuffle([Card], ShuffledDeck) ->
  [Card | ShuffledDeck];
knuth_shuffle(Deck, ShuffledDeck) ->
  Index = rand:uniform(length(Deck)),
  Card = lists:nth(Index, Deck),
  knuth_shuffle(lists:delete(Card, Deck), [Card | ShuffledDeck]).
