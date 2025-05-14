# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

RSpec.describe Player do
  describe '#input_coords' do
    # Located in Public Script Method #make_move
    # Looping Script Method -> Test its behavior
    # It could be classified as an incoming query message but it has too much responsibility
    # in my opinion (follow the Single Responsibility Principle). Also, testing the return value
    # depends on lots of things that has/should already be tested, so it should be ignored since
    # the return value depends on these already-tested methods in the looping script method
    subject(:player_input) { described_class.new('X') }
    let(:board) { instance_double(Board) }

    before do
      allow(player_input).to receive(:puts)
      allow(player_input).to receive(:choose_coord).and_return(0)
    end

    context 'when coordinates chosen contains an empty space' do
      before { allow(board).to receive(:at).and_return(' ') }

      it 'does not display error message' do
        expect(player_input).to_not receive(:puts).with('Invalid Input: A token already exists there')
        player_input.input_coords(board)
      end
    end

    context 'when coordinates chosen contains a token, then an empty space' do
      before { allow(board).to receive(:at).and_return('O', ' ') }

      it 'displays error message exactly once' do
        expect(player_input).to receive(:puts).with('Invalid Input: A token already exists there').once
        player_input.input_coords(board)
      end
    end

    context 'when coordinates chosen contains a token 3 times in a row, then an empty space' do
      before { allow(board).to receive(:at).and_return('O', 'X', 'O', ' ') }

      it 'displays error message 3 times exactly' do
        expect(player_input).to receive(:puts).with('Invalid Input: A token already exists there').exactly(3).times
        player_input.input_coords(board)
      end
    end
  end

  describe '#choose_coord' do
    # Located in Looping Script Method #input_coords
    # Looping Script Method -> Test its behavior
    subject(:player_choose) { described_class.new('X') }

    before do
      allow(player_choose).to receive(:puts)
      allow(player_choose).to receive(:gets).and_return('')
      allow(player_choose).to receive(:convert_to_zero_base)
    end

    context 'when the user input is valid' do
      before { allow(player_choose).to receive(:valid_coord?).and_return(true) }

      it 'does not display the error message' do
        expect(player_choose).to_not receive(:puts).with('Invalid Input: The coordinate must be from 1, 2, or 3')
        player_choose.choose_coord('row')
      end
    end

    context 'when the user input is invalid, then valid' do
      before { allow(player_choose).to receive(:valid_coord?).and_return(false, true) }

      it 'displays the error message exactly once' do
        expect(player_choose).to receive(:puts).with('Invalid Input: The coordinate must be from 1, 2, or 3').once
        player_choose.choose_coord('row')
      end
    end

    context 'when the user input is invalid 3 times in a row, then valid' do
      before { allow(player_choose).to receive(:valid_coord?).and_return(false, false, false, true) }

      it 'displays the error message exactly 3 times' do
        expect(player_choose).to receive(:puts).with('Invalid Input: The coordinate must be from 1, 2, or 3').exactly(3).times
        player_choose.choose_coord('row')
      end
    end
  end

  describe '#valid_coord?' do
    # Located in Looping Script Method #choose_coord
    # Incoming Query Message -> Test the return value
    subject(:player_valid) { described_class.new('X') }

    it 'returns false for empty string' do
      is_valid_coord = player_valid.valid_coord? ''
      expect(is_valid_coord).to be false
    end

    it 'returns false for space' do
      is_valid_coord = player_valid.valid_coord? ' '
      expect(is_valid_coord).to be false
    end

    it 'returns false for non-numeric p' do
      is_valid_coord = player_valid.valid_coord? 'p'
      expect(is_valid_coord).to be false
    end

    it 'returns false for mixture 1a' do
      is_valid_coord = player_valid.valid_coord? '1a'
      expect(is_valid_coord).to be false
    end

    it 'returns false for negative -1' do
      is_valid_coord = player_valid.valid_coord? '-1'
      expect(is_valid_coord).to be false
    end

    it 'returns false for below valid range 0' do
      is_valid_coord = player_valid.valid_coord? '0'
      expect(is_valid_coord).to be false
    end

    it 'returns false for above valid range 4' do
      is_valid_coord = player_valid.valid_coord? '4'
      expect(is_valid_coord).to be false
    end

    it 'returns true for in valid range 1' do
      is_valid_coord = player_valid.valid_coord? '1'
      expect(is_valid_coord).to be true
    end

    it 'returns true for in valid range 2' do
      is_valid_coord = player_valid.valid_coord? '2'
      expect(is_valid_coord).to be true
    end

    it 'returns true for in valid range 3' do
      is_valid_coord = player_valid.valid_coord? '3'
      expect(is_valid_coord).to be true
    end
  end

  describe '#convert_to_zero_base' do
    # Located in Looping Script Method #choose_coord
    # Incoming Query Message -> Test return value
    subject(:player_convert) { described_class.new('X') }

    it 'returns nil from empty string' do
      result = player_convert.convert_to_zero_base('')
      expect(result).to be_nil
    end

    it 'returns nil from string space' do
      result = player_convert.convert_to_zero_base(' ')
      expect(result).to be_nil
    end

    it 'returns nil from non-numeric string p' do
      result = player_convert.convert_to_zero_base('p')
      expect(result).to be_nil
    end

    it 'returns nil from mixture string 1a' do
      result = player_convert.convert_to_zero_base('1a')
      expect(result).to be_nil
    end

    it 'returns nil from space-number string " "1' do
      result = player_convert.convert_to_zero_base(' 1')
      expect(result).to be_nil
    end

    it 'returns nil from negative string -1' do
      result = player_convert.convert_to_zero_base('-1')
      expect(result).to be_nil
    end

    it 'returns nil from zero string 00' do
      result = player_convert.convert_to_zero_base('00')
      expect(result).to be_nil
    end

    it 'returns integer 0 from string 1' do
      result = player_convert.convert_to_zero_base('1')
      expect(result).to eql(0)
    end

    it 'returns integer 1 from string 02' do
      result = player_convert.convert_to_zero_base('02')
      expect(result).to eql(1)
    end

    it 'returns integer 2 from string 3' do
      result = player_convert.convert_to_zero_base('3')
      expect(result).to eql(2)
    end

    it 'returns integer 99 from string 100' do
      result = player_convert.convert_to_zero_base('100')
      expect(result).to eql(99)
    end
  end
end
