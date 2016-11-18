defmodule StateMachine do
  def get_driver do
    spawn(StateMachine, :sit, [])
  end

  def sit do
    receive do
      "honk" ->
        IO.puts "Beep, Beep"
      "start" ->
        IO.puts "Cranking..."
        start
      _ ->
        IO.puts "can't do that action right now"
    end
    sit
  end

  def start do
    receive do
      "honk" ->
        IO.puts "Beep, Beep"
      "drive" ->
        IO.puts "Vroom, Vroom"
        drive
      "kill" ->
        IO.puts "Put, put, put..."
        sit
      _ ->
        IO.puts "can't do that action right now"
    end
    start
  end

  def drive do
    receive do
      "honk" ->
        IO.puts "Beep, Beep"
      "turn" ->
        IO.puts "Screeeeech"
      "stop" ->
        IO.puts "Errt...."
        start
      _ ->
        IO.puts "can't do that action right now"
    end
    drive
  end
end
