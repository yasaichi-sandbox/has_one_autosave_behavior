require "rails_helper"

RSpec.describe Actor, type: :model do
  let(:actor) { Actor.create!(name: "Yui Aragaki") }

  after do
    Actor.memo_for_debug = 0
  end

  describe "#after_save for the instance having new association" do
    let!(:profile) { actor.build_actor_profile(debuted_on: "2005/1/10") }

    after do
      ActorProfile.memo_for_debug = 0
    end

    context "with #inverse_of" do
      context "when an attribute of #actor_profile is changed" do
        before do
          profile.debuted_on = Date.today
          profile.actor.save!
        end

        it { expect(Actor.memo_for_debug).to eq(2).or(eq(3)) }  # 2 for Rails 4.0
        it { expect(actor.memo_for_debug).to eq(1).or(eq(3)) }  # 1 for Rails 4.0
        it { expect(profile.memo_for_debug).to eq(0).or(eq(1)) }  # 0 for Rails 4.0
        it { expect(ActorProfile.memo_for_debug).to eq(0).or(eq(1)) } # 0 for Rails 4.0
      end

      context "when an attribute of #actor_profile isn't changed" do
        before do
          profile.actor.save!
        end

        it { expect(Actor.memo_for_debug).to eq(2).or(eq(3)) }  # 2 for Rails 4.0
        it { expect(actor.memo_for_debug).to eq(1).or(eq(3)) }  # 1 for Rails 4.0
        it { expect(profile.memo_for_debug).to eq(0).or(eq(1)) }  # 0 for Rails 4.0
        it { expect(ActorProfile.memo_for_debug).to eq(0).or(eq(1)) } # 0 for Rails 4.0
      end
    end

    context "without #inverse_of" do
      context "when an attribute of #actor_profile is changed" do
        before do
          profile.debuted_on = Date.today
          actor.save!
        end

        it { expect(Actor.memo_for_debug).to eq 3 }
        it { expect(actor.memo_for_debug).to eq(2).or(eq(3)) } # 2 for Rails 4.0
        it { expect(profile.memo_for_debug).to eq 1 }
        it { expect(ActorProfile.memo_for_debug).to eq 1 }
      end

      context "when an attribute of #actor_profile isn't changed" do
        before do
          actor.save!
        end

        it { expect(Actor.memo_for_debug).to eq 3 }
        it { expect(actor.memo_for_debug).to eq(2).or(eq(3)) } # 2 for Rails 4.0
        it { expect(profile.memo_for_debug).to eq 1 }
        it { expect(ActorProfile.memo_for_debug).to eq 1 }
      end
    end
  end
end
