RSpec.describe HealthCard::DiacriticsHelper do

  describe '.remove_diacritics' do

    class DiacriticsMockClass
      include HealthCard::DiacriticsHelper
    end

    subject { DiacriticsMockClass.new.remove_diacritics(string) }

    context 'when the string has diacritics' do
      let(:string) { 'äbcdéfghîj' }
      it('removes them') { is_expected.to eq('abcdefghij') }
    end

    context 'when the string has digits' do
      let(:string) { 'abc123' }
      it('does not remove them') { is_expected.to eq('abc123') }
    end

    context 'when the string has non-alpha-numeric characters' do
      let(:string) { "abc=(o'marc[])" }
      it('does not remove them') { is_expected.to eq("abc=(o'marc[])") }
    end

  end

end
