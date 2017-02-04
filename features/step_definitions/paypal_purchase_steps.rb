When(/^I view the confirmation page for token "(.*?)"$/) do |token|
  @donation_product = Product.create!(permalink: 'earlybird', name: 'testing-donation', price: 1800)
  Product.create!(permalink: 'double-chai', name: 'testing-donation-2', price: 3600)
  Product.create!(permalink: 'triple-chai', name: 'testing-donation-3', price: 5400)

  @express_token = token

  page.driver.browser.set_cookie('donate_product_id=earlybird')

  VCR.use_cassette("paypal_review_purchase-#{token.downcase}") do
    visit new_order_path(token: @express_token)
  end
end

Then(/^the paypal details should be displayed$/) do
  expect(page).to have_content("Full Name test buyer")
  expect(page).to have_content("Email baylorrae-buyer@gmail.com")
  expect(page).to have_content("Amount $18.00")
end

When(/^complete the purchase$/) do
  VCR.use_cassette("paypal_complete_purchase-#{@express_token.downcase}") do
    click_button 'Complete Purchase'
  end
end

Then(/^the payola sale should be created with paypal details$/) do
  expect(page).to have_content('Thank you for your donation')

  sale = Payola::Sale.last
  expect(sale.owner).to eq(@user)

  expect(@user.charter_member?).to be_truthy

  expect(sale.email).to eq('baylorrae-buyer@gmail.com')
  expect(sale.guid).to be_present
  expect(sale.product).to eq(@donation_product)

  expect(sale.state).to eq('finished')
  expect(sale.amount).to eq(1800)
  expect(sale.fee_amount).to eq(82)

  expect(sale.payment_source).to eq('paypal')
  expect(sale.paypal_payer_id).to eq('P37835M8939JA')
  expect(sale.paypal_express_token).to eq(@express_token)
  expect(sale.paypal_transaction_id).to eq('7SM13470Y8496020W')
end

Then(/^an error message should be displayed$/) do
  expect(page).to have_content('PayPal Error (10415) A successful transaction has already been completed for this token.')
  
  click_link 'Cancel and Try Again'
end
