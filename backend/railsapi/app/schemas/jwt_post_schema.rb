class JwtPostSchema < Dry::Validation::Contract
  params do
    required(:email).filled(:string, size?: 10..50, format?: /^[a-z0-9.-]+@[a-z0-9-]+\.[a-z0-9.-]+$/i)
    required(:password).filled(:string, size?: 8..20, format?: /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+$/i)
  end
end
