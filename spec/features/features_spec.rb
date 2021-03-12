# frozen_string_literal: true

require 'spec_helper.rb'

describe 'Table sorting and filtering tests', js: true do
  before do
    visit '/'
  end

  xit 'Sorting of table by Price field', js: true do
    find('p', text: 'Price').click
    @previous_price = 100_000

    page.all(:xpath, "//div[contains(@class, 'price')]//a").each do |element|
      price = element.text[1..-1].delete(',').to_f

      expect(price).to be <= @previous_price

      @previous_price = price
    end
  end

  it 'Filtering of table by Price field', js: true do
    click_button 'Filter'
    click_button 'Price'
    find(:xpath, "//button[text()='$0 - $1']").click
    find(:xpath, '//button[@data-qa-id="filter-dd-button-apply"]').click

    page.all(:xpath, "//div[contains(@class, 'price')]//a").each do |element|
      price = element.text[1..-1].delete(',').to_f

      expect(price).to be <= 1
    end
  end

  xit 'Pagination of table with data check in table', js: true do
    expect(page).to have_css('.pagination')

    next_button = find(:xpath, '//a[@aria-label="Next page"]')
    all_pages = page.all(:xpath, '//li[@class="page"]')
    last_page = all_pages[-1].text

    while next_button['aria-disabled'] == 'false'
      next_button.click
      current_page = find(:xpath, '//li[@class="page active"]')
      expect(page.current_url).to include(current_page.text)

      next unless last_page != current_page.text

      sleep 1
      all_elements = page.all(:xpath, '//tbody//tr')
      expect(all_elements.length).to be == 101
    end
  end
end
