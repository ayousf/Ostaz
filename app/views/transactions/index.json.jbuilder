json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :from, :to, :amount
  json.url transaction_url(transaction, format: :json)
end
