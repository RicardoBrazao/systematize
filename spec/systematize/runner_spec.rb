require 'spec_helper'

describe Systematize::Runner do

  describe '#run' do

    subject{
      described_class.run do |temp_folder|
        "The temp folder is at #{temp_folder}"
      end
    }

    before do

      stub_const('Systematize::Runner::DB_FOLDER_PATH', './spec/support/db')
      stub_const('Systematize::Runner::DATA_MIGRATIONS_PATH', "#{Systematize::Runner::DB_FOLDER_PATH}/data")
      stub_const('Systematize::Runner::STRUCTURE_MIGRATIONS_PATH', "#{Systematize::Runner::DB_FOLDER_PATH}/migrate")
      stub_const('Systematize::Runner::TEMP_MIGRATIONS_FOLDER_PATH', "#{Systematize::Runner::DB_FOLDER_PATH}/tmp")

      allow(FileUtils).to receive(:mkdir).and_call_original
      allow(FileUtils).to receive(:rm_rf).and_call_original
      allow(FileUtils).to receive(:cp_r).and_call_original

      subject
    end


    it 'creates a temp folder where all the migrations will be' do
      expect(FileUtils).to have_received(:mkdir).once
    end

    it 'deletes the temp folder where all the migrations were' do
      expect(FileUtils).to have_received(:rm_rf).once
    end

    it 'copies the content of /db/migrate to /db/temp' do
      expect(FileUtils)
        .to have_received(:cp_r)
        .with(Dir.glob("#{Systematize::Runner::STRUCTURE_MIGRATIONS_PATH}/*.rb"), Systematize::Runner::TEMP_MIGRATIONS_FOLDER_PATH)
        .once
    end

    it 'copies the content of /db/data to /db/temp' do
      expect(FileUtils)
        .to have_received(:cp_r)
        .with(Dir.glob("#{Systematize::Runner::DATA_MIGRATIONS_PATH}/*.rb"), Systematize::Runner::TEMP_MIGRATIONS_FOLDER_PATH)
        .once
    end

    # Test if #run yields the block that it receives
    specify{
      expect{ |b|
        described_class.run(&b)
      }
      .to yield_with_args(Systematize::Runner::TEMP_MIGRATIONS_FOLDER_PATH)
    }

  end

end