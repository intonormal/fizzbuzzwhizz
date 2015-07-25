-module(game_1).
-compile(export_all).

contains(N) ->
	fun(M) ->
		P1 = M rem 10,
		P2 = M div 10 rem 10,
		P3 = M div 10 div 10 rem 10,
		P1 =:= N orelse P2 =:= N orelse P3 =:= N
	end.

mutil(N) ->
	fun(M) ->
		M rem N =:= 0
	end.


pred(N) ->
	case (contains(3))(N) of
		true -> "Fizz";
		false ->
			case (mutil(105))(N) of
				true -> "FizzBuzzWhizz";
				false -> 
					case (mutil(35))(N) of
						true -> "BuzzWhizz";
						false ->
							case (mutil(21))(N) of
								true -> "FizzWhizz";
								false ->
									case (mutil(15))(N) of
										true -> "FizzBuzz";
										false -> 
											case (mutil(7))(N) of
												true -> "Whizz";
												false -> 
													case (mutil(5))(N) of
														true -> "Buzz";
														false ->
															case (mutil(3))(N) of
																true -> "Fizz";
																false -> N
															end
													end
											end
									end
							end
					end
			end
	end.

game_1() ->
	[pred(I)||I <- lists:seq(1, 100)].
