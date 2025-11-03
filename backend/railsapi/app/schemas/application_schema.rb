class ApplicationSchema < Dry::Validation::Contract
  register_macro :validate_email do
    key.failure(
      "Email must be 10-50 characters and a standard email format"
    ) unless value.match?(
      /^(?=.{10,50}$)[a-z0-9.-]+@[a-z0-9-]+\.[a-z0-9.-]+$/i
    )
  end

  register_macro :validate_password do
    key.failure(
      "Password must be 8-20 characters and include at least 1 uppercase, 1 lowercase, and 1 number"
    ) unless value.match?(
      /^(?=.{8,20}$)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+$/i
    )
  end

  register_macro :validate_name do
    key.failure(
      "Name must be 1-30 characters"
    ) unless value.match?(
      /^.{1,30}$/i
    )
  end
end
