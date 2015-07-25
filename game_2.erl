-module(game_2).
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

rule(Pred, Trans) ->
	fun(N) ->
		case Pred(N) of 
			true -> {true, Trans(N)};
			false -> false
		end
	end.

replace(M) ->
	R3 = rule(contains(3), fun(_) -> "Fizz" end),
	Rd = rule(fun(_) -> true end, fun(N) -> N end),
	R1_3 = rule(mutil(3), fun(_) -> "Fizz" end),
	R1_5 = rule(mutil(5), fun(_) -> "Buzz" end),
	R1_7 = rule(mutil(7), fun(_) -> "Whizz" end),
	R15 = rule(mutil(15), fun(_) -> "FizzBuzz" end),
	R21 = rule(mutil(21), fun(_) -> "FizzWhizz" end),
	R35 = rule(mutil(35), fun(_) -> "BuzzWhizz" end),
	R105 = rule(mutil(105), fun(_) -> "FizzBuzzWhizz" end),
	case R3(M) of
		{true, A} -> A;
		false ->
			case R105(M) of
				{true, B} -> B;
				false ->
					case R35(M) of
						{true, C} -> C;
						false ->
							case R21(M) of
								{true, D} -> D;
								false ->
									case R15(M) of
										{true, E} -> E;
										false -> 
											case R1_7(M) of
												{true, F} -> F;
												false ->
													case R1_5(M) of
														{true, G} -> G;
														false ->
															case R1_3(M) of
																{true, H} -> H;
																false -> 
																	case Rd(M) of 
																		{true, J} -> J;
																		false -> false
																	end
															end
													end
											end
									end
							end
					end
			end
	end.


game_2() ->
	[replace(I)||I <- lists:seq(1, 100)].
