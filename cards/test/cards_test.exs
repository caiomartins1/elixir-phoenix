defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck returns a list of 56 cards" do
    deck_length = length(Cards.create_deck())
    assert deck_length == 56
  end
end
