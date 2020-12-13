require './lib/input'
require './lib/grid'
require 'stringio'

describe Input do
  before do
    $stdin = StringIO.new("3\n")
  end

  after do
    $stdin = STDIN
  end


  subject(:input) { described_class.new('John', "\u26BD ", grid) }
  let(:grid) { Grid.new }

  context 'generates input attributes' do

    describe "#ask_input" do
      it "asks input from 1-7" do
        phrase = "#{input.player}'s turn: choose your slot, drop #{input.token}\n"

        expect { input.ask_input }.to output(phrase).to_stdout
      end
    end

    describe "#input_attributes" do
      context "it creates the following input attributes:" do
        it "avail_vertical" do
          expect(input.avail_vertical).to eq(6)
        end

        it "column_index" do
          expect(input.column_index).to eq(0)
        end

        it "row_index" do
          expect(input.row_index).to eq(2)
        end

        it "reversed_index" do
          expect(input.reversed_index).to eq(4)
        end

        it "is_valid" do
          expect(input.is_valid).to be_truthy
        end
      end
    end
  end
end

