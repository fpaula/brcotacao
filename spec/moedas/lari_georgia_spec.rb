require 'spec_helper'

describe BrCotacao::LariGeorgia do
  subject { BrCotacao::LariGeorgia.new }

  describe '.cotacao' do

    it_should_behave_like 'banco central fora', :cotacao

    context 'quando o banco central esta no ar' do

      it_should_behave_like 'dia sem cotacao', :cotacao

      context "e o dia pesquisado tem cotacao" do
        let(:data_pesquisada) { Date.new(2012, 2, 2)  }
        let(:valor_esperado) { {:compra => 1.0885, :venda => 1.0988} }

        before do
          Net::HTTP.any_instance.stub(:get).and_return(double(:msg => 'OK', :body => fixure('20111209.csv')))
        end

        it_should_behave_like 'dia com cotacao', :cotacao
      end
    end
  end

  describe '.compra' do

    it_should_behave_like 'banco central fora', :compra

    context 'quando o banco central esta no ar' do

      it_should_behave_like 'dia sem cotacao', :compra

      context "e o dia pesquisado tem cotacao" do
        let(:data_pesquisada) { Date.new(2012, 2, 2)  }
        let(:valor_esperado) { 1.0885 }

        before do
          Net::HTTP.any_instance.stub(:get).and_return(double(:msg => 'OK', :body => fixure('20111209.csv')))
        end

        it_should_behave_like 'dia com cotacao', :compra
      end
    end
  end

  describe '.venda' do

    it_should_behave_like 'banco central fora', :venda

    context 'quando o banco central esta no ar' do

      it_should_behave_like 'dia sem cotacao', :venda

      context "e o dia pesquisado tem cotacao" do
        let(:data_pesquisada) { Date.new(2012, 2, 2)  }
        let(:valor_esperado) { 1.0988 }

        before do
          Net::HTTP.any_instance.stub(:get).and_return(double(:msg => 'OK', :body => fixure('20111209.csv')))
        end

        it_should_behave_like 'dia com cotacao', :venda
      end
    end
  end

  describe '.cotacao_agora' do
    it_should_behave_like 'cotacao tempo real', :cotacao_agora
  end
end
