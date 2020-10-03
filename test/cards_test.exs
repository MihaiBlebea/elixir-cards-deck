defmodule CardsTest do
    use ExUnit.Case

    alias Cards
    # doctest Cards

    test "can create deck" do
        d = Cards.create_deck
        assert is_list(d)
    end

    test "deck has correct type values" do
        d = Cards.create_deck
        [ {suit, value} | _] = d
        assert is_atom(suit)
        assert is_integer(value)
    end

    test "deck has correct suits" do
        [ {suit, _} | _] = Cards.create_deck
        assert Enum.member?([:spades, :clubs, :hearts, :diamonds], suit)
    end

    test "deck has correct values" do
        [ {_, value} | _] = Cards.create_deck
        assert Enum.member?([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14], value)
    end

    test "deck can be shuffled" do
        d = Cards.create_deck
        s = Cards.shuffle(d)
        refute d == s
    end

    test "deck can be dealt" do
        d = Cards.create_deck
        { hand, _ } = Cards.deal(d, 5)
        [{suit, value} | _] = hand
        assert length(hand) == 5
        assert is_atom(suit)
        assert is_integer(value)
    end

    test "hand can be dealt with one method" do
        { hand, _ } = Cards.create_hand(5)
        [{suit, value} | _] = hand
        assert length(hand) == 5
        assert is_atom(suit)
        assert is_integer(value)
    end

    test "deck contains card" do
        assert Cards.contains?(Cards.create_deck(), {:spades, 4})
    end

    test "deck can be counted" do
        assert Cards.count(Cards.create_deck()) == 52
    end

    test "deck can be stored and retrieved from file" do
        f = "test_storage_file.txt"
        d = Cards.create_deck()
        Cards.save(d, f)
        p = Cards.load(f)
        File.rm(f)
        assert d == p
    end
end
