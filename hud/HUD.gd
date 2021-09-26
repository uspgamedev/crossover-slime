extends CanvasLayer

func set_power_name(power_name: String):
	$InfoSidebar/Second/Margin/PowerHint.text = "Current: %s" % power_name
