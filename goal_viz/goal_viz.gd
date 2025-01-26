extends Control

func set_color(ideal: Color, color: Color):
	%R_gauge.set_ideal(ideal.r)
	%R_gauge.set_amount(color.r)
	%G_gauge.set_ideal(ideal.g)
	%G_gauge.set_amount(color.g)
	%B_gauge.set_ideal(ideal.b)
	%B_gauge.set_amount(color.b)
	
func set_total(ideal: float, amount: float):
	%Total_gauge.set_ideal(ideal)
	%Total_gauge.set_amount(amount)

func set_bonus(bonus: float):
	%score.text = "x" + str(float(int(bonus * 10.0)) / 10.0)
