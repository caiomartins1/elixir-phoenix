defmodule Cards do
  @moduledoc """
    Provides functions for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing the deck of playing cards
  """
  def create_deck do
    values = ["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits = ["Spades", "Diamonds", "Hearts", "Clubs"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Checks if a given card exists in the given deck

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(2)> Cards.contains?(deck, "A of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Divides a deck into a hand and remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _} = Cards.deal(deck, 1)
      iex> hand
      ["A of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)

    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "File does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
