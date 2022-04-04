defmodule Nasafuel do
  @moduledoc """
  The goal of this application is to calculate fuel to launch from one planet of the Solar system, and to land on another planet of the Solar system,
  depending on the flight route.
  """
  @doc """
  The calculation uses different formulas for launch and landing while accounting for the mass and gravity.

  ## Examples

      iex> Nasafuel.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
      :33456

  """

def add_fuel(fuel) do
    cond do
      fuel >= 9278 -> fuel + 2960 + 915 + 254 + 40
      fuel >= 2960 -> fuel + 915 + 254 + 40
      fuel >= 915 -> fuel + 254 + 40
      fuel >= 254 -> fuel + 40
      true -> fuel
    end
  end

def calculate(mass, gravity) do
  Enum.reduce(gravity, 0, fn step, total_fuel ->
    {type, constant} = step
    step_fuel_usage = case type do
      :launch -> Kernel.trunc(((mass * constant) * 0.042) - 33)
      :land -> Kernel.trunc(((mass * constant) * 0.033) - 42)
    end
    add_fuel(step_fuel_usage) + total_fuel
  end)
end
end
