# Prints the value of the layer height corresponds to a whole number of steps

pitch = 1.25 # mm; 0.8mm for M5, 1.25mm for M8
substeps = 32 # 1,2,4,8,16 for A4988; 1,2,4,8,16,32 for DRV8825
motor_step = 1.8 # deg/step; 0.9 or 1.8 degrees/step

from = 0.00 # mm
to = 0.41 # mm; nozzle size
by = 0.01 # mm

steps_by_mm = 360/motor_step*substeps/pitch
prev_layer_height = 0
best_layer_height = to*0.6 # 60% of nozzle size

height_steps = []
puts "Steps by 1mm: #{steps_by_mm}"
puts "Best layer height: #{best_layer_height}mm (60% of #{to}mm)"
((steps_by_mm*from).round..(steps_by_mm*to).round).to_a.each do |i|
	layer_height = i.to_f/steps_by_mm
	height_steps << [layer_height, i] if layer_height.to_s.split('.')[1].size < 5
end

best_height, best_steps = height_steps.sort {|a, b| (a[0] - best_layer_height).abs <=> (b[0] - best_layer_height).abs }.first

height_steps.each do |height, steps|
	puts "#{height}\t(#{steps}) #{'<= best' if steps == best_steps}"
end