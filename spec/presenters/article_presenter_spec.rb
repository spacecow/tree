require 'spec_helper'

describe ArticlePresenter do
  let(:spawn){ create(:character)}
  let(:violator){ create(:character)}
  let(:batman){ create(:character)}
  let(:presenter){ ArticlePresenter.new(spawn, view)}

  describe '#histories' do
    before do
      spawn.histories << mock_model(History).as_null_object
    end
    subject{ Capybara.string(presenter.histories).find('div.histories')} 
    it{ should have_selector 'span.history' }
  end

  describe '#relations' do
    context 'without relations' do
      it{ presenter.relations.should be_nil }
    end #without relations

    context 'with enemies&friends' do
      before do
        create(:enemy, article:spawn, relative:violator)
        create(:friend, article:spawn, relative:batman)
        view.stub(:pl){ nil }
      end

      describe 'div.relations' do
        subject{ Capybara.string(presenter.relations).find('div.relations') }
        it{ should have_selector 'ul.enemies' }
        it{ should have_selector 'ul.friends' }
      end # div.relations
    end # with enemies&friends
  end # #relations

  describe '#enemies' do
    context 'with friends' do
      before{ create(:friend, article:spawn, relative:violator)}
      it{ presenter.enemies.should be_blank }
    end

    context 'with inverse enemy' do
      before do
        create(:enemy, article:violator, relative:spawn)
        view.stub(:pl){ t(:enemy,count:2) }
      end
      subject{ Capybara.string(presenter.relations)}
      it{ should have_selector 'h2', text:'Enemies' }

      describe 'ul.enemies' do
        subject{ Capybara.string(presenter.relations).find('ul.enemies')}
        it{ should have_selector 'li.relation.enemy', count:1 }
      end
    end

    context 'with enemies' do
      before do
        create(:enemy, article:spawn, relative:violator)
        view.stub(:pl){ t(:enemy,count:2) }
      end

      subject{ Capybara.string(presenter.relations)}
      it{ should have_selector 'h2', text:'Enemies' }

      describe 'ul.enemies' do
        subject{ Capybara.string(presenter.relations).find('ul.enemies')}
        it{ should have_selector 'li.relation.enemy', count:1 }
      end
    end
  end

  describe '#participants' do
    context 'with friends' do
      before{ create(:friend, article:spawn, relative:violator)}
      it{ presenter.participants.should be_blank }
    end

    context 'with inverse participant' do
      before do
        create(:participant, article:violator, relative:spawn)
        view.stub(:pl){ t(:participant_in,count:2) }
      end
      it{ presenter.participants.should be_blank }

      subject{ Capybara.string(presenter.participant_ins)}
      it{ should have_selector 'h2', text:'Participant in' }

      describe 'ul.participant_ins' do
        subject{ Capybara.string(presenter.participant_ins).find('ul.participant_ins')}
        it{ should have_selector 'li.relation.participant_in', count:1 }
      end
    end

    context 'with participants' do
      before do
        create(:participant, article:spawn, relative:violator)
        view.stub(:pl){ t(:participant,count:2) }
      end

      subject{ Capybara.string(presenter.participants)}
      it{ should have_selector 'h2', text:'Participants' }

      describe 'ul.participants' do
        subject{ Capybara.string(presenter.participants).find('ul.participants')}
        it{ should have_selector 'li.relation.participant', count:1 }
      end
    end
  end
end
