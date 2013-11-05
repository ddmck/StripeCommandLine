require 'stripe'

def getPlans
  Stripe::Plan.all(count: 999) 
end

def deletePlans
  Stripe.api_key = @live_key
  live_plans = getPlans
  live_plans.each do |plan|
    plan.delete
  end
end

def createPlan(plan)
  Stripe::Plan.create(
    :amount => plan.amount,
    :interval => plan.interval,
    :name => plan.name,
    :currency => plan.currency,
    :id => plan.id
  )
end

@test_key = nil
@live_key = nil

unless @test_key
  print "Please enter your Stripe test secret key: " 
  @test_key = gets.chomp
end 
Stripe.api_key = @test_key

test_plans = getPlans
unless @live_key
  print "Please enter your Stripe live secret key: "
  @live_key = gets.chomp
end
Stripe.api_key = @live_key

test_plans.each do |plan|
  createPlan(plan)
end