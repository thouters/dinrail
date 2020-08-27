# https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script.3F
#
.PHONY: all clean
OUT=output
all: \
	$(OUT)/clickpi_dinrail.stl \
	$(OUT)/icyboxssd_dinrail.stl \
	$(OUT)/usbhub_dinrail.stl \
	$(OUT)/moca_dinrail.stl \
	$(OUT)/mybook.stl \
	$(OUT)/mybookdin.stl \
	$(OUT)/statuslcd.stl \
	$(OUT)/statuslcd_din.stl \
	$(OUT)/statuslcd_top.stl \
	$(OUT)/statuslcd_front.stl \
	$(OUT)/fan_5x5_dinrail.stl  

output/mybook.stl: mybook.scad 
	openscad -DPARTNO=0 -Dfdm=1  -o $@ $<

output/mybookdin.stl: mybook.scad 
	openscad -DPARTNO=1 -Dfdm=1  -o $@ $<

output/statuslcd_din.stl: statuslcd.scad 
	openscad -DPARTNO=1 -Dfdm=1  -o $@ $<

output/statuslcd_top.stl: statuslcd.scad 
	openscad -DPARTNO=3 -Dfdm=1  -o $@ $<

output/statuslcd_front.stl: statuslcd.scad 
	openscad -DPARTNO=2 -Dfdm=1  -o $@ $<



output/%.stl: %.scad 
	openscad -DPARTNO=0 -Dfdm=1 -o $@ $<


clean:
	rm $(OUT)/*.stl
$(shell   mkdir -p $(OUT))
