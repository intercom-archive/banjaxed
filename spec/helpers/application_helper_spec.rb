require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#render_user_content' do
    subject(:rendered_content) { helper.render_user_content(content) }

    context "given Markdown" do
      let(:content) { "# incident title" }

      it "renders Markdown as HTML" do
        expect(rendered_content).to eq("<h1>incident title</h1>")
      end
    end

    context "given unsafe content" do
      let(:content) { '<script>alert(document.cookie)</script>' }

      it "sanitizes the content" do
        expect(rendered_content).to eq("")
      end
    end

    context "given plaintext URLs" do
      let(:content) { 'http://butt.holdings' }

      it "converts URLs into HTML links" do
        expect(rendered_content).to eq('<p><a href="http://butt.holdings">http://butt.holdings</a></p>')
      end
    end
  end
end
