# Holds current game data
# 518 is the number of stat points a person would
# have at level 100 assuming they evolved classes
# at the lowest possible levels (10,25,50,75)
# and then reached level 100.
	# 3 * 10 = 30
	# 4 * 15 = 60
	# 5 * 25 = 125
	# 6 * 25 = 150
	# 7 * 25 = 175

#var base_speed: float
# Actual movement speed is the base_speed + ((current - base agility) * (base_speed * .01))
