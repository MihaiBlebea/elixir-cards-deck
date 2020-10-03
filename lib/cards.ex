defmodule Cards do
    @moduledoc """
    Provides methods to crete and handle a deck of cards

    `Cards.create_deck/0`

    #### Example:
        iex> d = Cards.create_deck
        iex> s = Cards.shuffle(d)
        iex> {hand, deck} = Cards.deal(s, 2)
        iex> hand
        [{:spades, 3}, {:clubs, 6}]

    Or you could use one single method as in:
        iex> {hand, deck} = Cards.create_hand(5)
    """

    @doc """
    Cretes a deck of playing cards
    """
    def create_deck() do
        values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14]
        suits = [:spades, :clubs, :hearts, :diamonds]

        for suit <- suits, value <- values do
            {suit, value}
        end
    end

    @doc """
    Accepts a deck and shuffles it
    """
    def shuffle([{suit, value} | _] = deck) when is_atom(suit) and is_integer(value) do
        Enum.shuffle(deck)
    end

    def deal([{suit, value} | _] = deck, hand_size) when is_atom(suit) and is_integer(value) do
        Enum.split(deck, hand_size)
    end

    def count(deck) do
        length(deck)
    end

    def contains?(deck, card) do
        Enum.member?(deck, card)
    end

    def save([{suit, value} | _] = deck, file_name)
        when is_atom(suit)
        and is_integer(value)
        and is_binary(file_name) do
            binary = :erlang.term_to_binary(deck)
            File.write(file_name, binary)
    end

    def load(file_name) when is_binary(file_name) do
        case File.read(file_name) do
            {:ok, binary} -> :erlang.binary_to_term(binary)
            {:error, _ } -> "File does not exist"
        end
    end

    def create_hand(hand_size) when is_integer(hand_size) do
        create_deck()
        |> shuffle()
        |> deal(hand_size)
    end

end
