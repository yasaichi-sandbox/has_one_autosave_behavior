require "rails_helper"

RSpec.describe Artist, type: :model do
  let(:artist) { Artist.create!(name: "Keyakizaka 46") }

  after do
    Artist.memo_for_debug = 0
  end

  describe "#after_save" do
    let!(:profile) { artist.create_artist_profile!(debuted_on: "2016/4/6") }

    after do
      ArtistProfile.memo_for_debug = 0
    end

    context "with #inverse_of" do
      context "when an attribute of #artist_profile is changed" do
        before do
          profile.debuted_on = Date.today
          profile.artist.save!
        end

        it { expect(Artist.memo_for_debug).to eq 2 }
        it { expect(artist.memo_for_debug).to eq(1).or(eq(2)) } # 1 for Rails 4.0
        it { expect(profile.memo_for_debug).to eq 1 }
        it { expect(ArtistProfile.memo_for_debug).to eq 1 }
      end

      context "when an attribute of #artist_profile isn't changed" do
        before do
          profile.artist.save!
        end

        it { expect(Artist.memo_for_debug).to eq 2 }
        it { expect(artist.memo_for_debug).to eq(1).or(eq(2)) } # 1 for Rails 4.0
        it { expect(profile.memo_for_debug).to eq 1 }
        it { expect(ArtistProfile.memo_for_debug).to eq 1 }
      end
    end

    context "without #inverse_of" do
      context "when an attribute of #artist_profile is changed" do
        before do
          profile.debuted_on = Date.today
          artist.save!
        end

        it { expect(Artist.memo_for_debug).to eq 2 }
        it { expect(artist.memo_for_debug).to eq 2 }
        it { expect(profile.memo_for_debug).to eq 1 }
        it { expect(ArtistProfile.memo_for_debug).to eq 1 }
      end

      context "when an attribute of #artist_profile isn't changed" do
        before do
          artist.save!
        end

        it { expect(Artist.memo_for_debug).to eq 2 }
        it { expect(artist.memo_for_debug).to eq 2 }
        it { expect(profile.memo_for_debug).to eq 1 }
        it { expect(ArtistProfile.memo_for_debug).to eq 1 }
      end
    end
  end
end
