Facter.add('hostrole') do
  setcode do
    Facter::Core::Execution.exec('/usr/bin/printenv HOSTROLE')
  end
end
