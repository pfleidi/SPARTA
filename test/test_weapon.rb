require 'helper'

class WeaponTest < Test::Unit::TestCase

  include Sparta

  def setup
    @weapon = Weapon.create(:ApacheBenchmark)
  end

  def test_load_weapons
    assert(Weapon.weapons.length > 0)
  end

  def test_create
    assert(@weapon.kind_of?(Weapon))
    assert(@weapon.instance_of?(ApacheBenchmark))
  end

  def test_install
    bootcamp = mock_install
    @weapon.install(bootcamp)
  end

  def test_use
    use_target = "http://xerxes.com" 
    use_opts = { :requests => 100, :clients => 20 }
    bootcamp = mock_install

    bootcamp.expects(:ssh).with(@weapon.usage_description(use_target, use_opts))
    @weapon.install(bootcamp)
    @weapon.use(use_target, use_opts)
  end

  def test_install_fail
    bootcamp = mock_install(nil)

    assert_raise(RuntimeError) do
      @weapon.install(bootcamp)
    end
  end

  def test_creation_fail
    assert_raise(RuntimeError) do
      @weapon = Weapon.create(:WeaponDoesNotExist)
    end
  end

  def mock_install(success_return = {})
    bootcamp = mock
    seq = sequence('loading weapon')
    bootcamp.expects(:ssh).with(@weapon.test_description).returns(nil).in_sequence(seq)

    @weapon.package_description.each do |manager, command|

      if manager == :pacman
        bootcamp.expects(:ssh).with(command).returns({}).in_sequence(seq)
        bootcamp.expects(:ssh).with(@weapon.test_description).returns(success_return).in_sequence(seq)
        done = true
      else
        bootcamp.expects(:ssh).with(command).returns(nil).in_sequence(seq)
      end

      break if done
    end

    bootcamp
  end

end
